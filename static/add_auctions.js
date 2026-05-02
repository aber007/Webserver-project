const loadingByContainer = new Map();

const add_auctions = async (
  sort_method = "published_at",
  auctions_offset = 0,
  auctions_per_page = 8,
  category = "",
  auctions_location_id = "auctions-grid",
  options = {},
  query = "",
) => {
  const loadingKey = auctions_location_id || "default";
  if (loadingByContainer.get(loadingKey)) return;
  loadingByContainer.set(loadingKey, true);
  console.log("Fetching auctions");
  const auctions_grid = document.getElementById(auctions_location_id);
  if (!auctions_grid) {
    loadingByContainer.set(loadingKey, false);
    return;
  }
  const cardSelector = options.cardSelector || ".auction-preview-card";
  const placeholderSelector =
    options.placeholderSelector || ".auction-preview-placeholder";
  const owner_id = options.owner_id;
  let auctions = [];
  let url = "";
  const formatTime = (seconds) => {
    if (!Number.isFinite(seconds)) return "";
    const clamped = Math.max(0, Math.floor(seconds));
    const days = Math.floor(clamped / 86400);
    const hours = Math.floor((clamped % 86400) / 3600);
    const minutes = Math.floor((clamped % 3600) / 60);
    const secs = clamped % 60;
    if (days > 0) return `${days}d ${hours}h`;
    if (hours > 0) return `${hours}h ${minutes}m`;
    return `${minutes}m ${secs}s`;
  };
  const remainingSeconds = (publishedAt, durationSeconds) => {
    const startMs = Date.parse(publishedAt);
    if (Number.isNaN(startMs) || !Number.isFinite(durationSeconds)) return 0;
    const endMs = startMs + Math.max(0, durationSeconds) * 1000;
    return Math.max(0, Math.floor((endMs - Date.now()) / 1000));
  };
  const params = new URLSearchParams({
    count: String(auctions_per_page),
    offset: String(auctions_offset),
    sort: sort_method,
    query,
  });
  if (category) {
    params.set("category", category);
  }
  if (owner_id !== undefined && owner_id !== null && owner_id !== "") {
    params.set("owner_id", String(owner_id));
  }
  url = `${window.location.origin}/api/auctions?${params.toString()}`;
  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error("Response not ok: " + response.status);
    }
    auctions = await response.json();
  } catch (error) {
    console.error("Error fetching auctions:", error);
    auctions_grid.innerHTML =
      "<p class='error-message'>Failed to load auctions. Please try again later.</p>";
    loadingByContainer.set(loadingKey, false);
    return;
  }
  const auctionElements = [];
  if (auctions.length === 0) {
    if (auctions_offset === 0) {
      auctions_grid.innerHTML =
        "<p class='no-auctions-message'>No active auctions found.</p>";
    } else {
      const placeholders = auctions_grid.querySelectorAll(placeholderSelector);
      placeholders.forEach((p) => p.closest(cardSelector)?.remove());
      if (window.auctionsScrollHandler) {
        window.removeEventListener("scroll", window.auctionsScrollHandler);
      }
    }
    loadingByContainer.set(loadingKey, false);
    return;
  }
  auctions_offset += auctions.length;

  for (const auction of auctions) {
    // Check if auction is expired
    const isExpired =
      remainingSeconds(auction.published_at, auction.auction_time) <= 0;
    if (isExpired) {
      try {
        await fetch(`${window.location.origin}/api/auctions/remove_published`, {
          method: "PUT",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ auction_id: auction.id }),
        });
      } catch (error) {
        console.error("Error updating auction status:", error);
      }
      continue; // Skip rendering this auction
    }

    const auctionCard = document.createElement("div");
    const bidCount = Number.isFinite(auction.bid_count)
      ? auction.bid_count
      : Number.isFinite(auction.bids)
        ? auction.bids
        : 0;
    const tags = [];
    if (auction.category_name) {
      tags.push(auction.category_name);
    }
    if (auction.auction_condition) {
      tags.push(auction.auction_condition);
    }
    if (auction.location) {
      tags.push(auction.location);
    }
    const tagsMarkup = tags.length
      ? tags
          .map((tag) => `<span class="auction-preview-tag">${tag}</span>`)
          .join("")
      : "";
    const endsIn = formatTime(
      remainingSeconds(auction.published_at, auction.auction_time),
    );
    auctionCard.className = "auction-preview-card auction-preview-card--small";
    auctionCard.setAttribute("data-auction-id", auction.id);
    auctionCard.addEventListener("click", () => {
      window.location.href = `/auctions/${auction.id}`;
    });
    auctionCard.innerHTML = `
                    <div class="auction-preview-image" style="background-image: url('${auction.image_small}')"></div>
                    <div class="auction-preview-body">
                        <div class="auction-preview-price">SEK ${auction.price}</div>
                        <h3 class="auction-preview-title">${auction.name}</h3>
                        <div class="auction-preview-tags">${tagsMarkup}</div>
                        <div class="auction-preview-footer">
                            <span class="auction-preview-bids">${bidCount} ${
                              bidCount === 1 ? "bid" : "bids"
                            }</span>
                            <span class="auction-preview-time">Ends in ${endsIn}</span>
                        </div>
                    </div>
                `;
    const timeLeftSpan = auctionCard.querySelector(".auction-preview-time");
    if (timeLeftSpan) {
      auctionElements.push({
        element: timeLeftSpan,
        published_at: auction.published_at,
        auction_time: auction.auction_time,
      });
    }

    const firstPlaceholder = auctions_grid
      .querySelector(placeholderSelector)
      ?.closest(cardSelector);
    if (firstPlaceholder) {
      auctions_grid.insertBefore(auctionCard, firstPlaceholder);
    } else {
      auctions_grid.appendChild(auctionCard);
    }
  }

  // Update times every second
  if (auctionElements.length > 0) {
    setInterval(() => {
      auctionElements.forEach(({ element, published_at, auction_time }) => {
        element.textContent = `Ends in ${formatTime(
          remainingSeconds(published_at, auction_time),
        )}`;
      });
    }, 1000);
  }
  loadingByContainer.set(loadingKey, false);
  return auctions_offset;
};
