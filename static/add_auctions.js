const loadingByContainer = new Map();

const add_auctions = async (
    sort_method = "published_at",
    auctions_offset = 0,
    auctions_per_page = 8,
    category = "",
    auctions_location_id = "auctions-grid",
    options = {},
) => {
    const loadingKey = auctions_location_id || "default";
    if (loadingByContainer.get(loadingKey)) return;
    loadingByContainer.set(loadingKey, true);
    console.log("Fetching auctions");
    console.log("Current offset:", auctions_offset);
    const auctions_grid = document.getElementById(auctions_location_id);
    if (!auctions_grid) {
        loadingByContainer.set(loadingKey, false);
        return;
    }
    const template =
        options.template || auctions_grid.dataset.auctionTemplate || "auction";
    const cardSelector =
        options.cardSelector ||
        (template === "index" ? ".item-card" : ".auction-card");
    const placeholderSelector =
        options.placeholderSelector || ".placeholder-image";
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
        if (Number.isNaN(startMs) || !Number.isFinite(durationSeconds))
            return 0;
        const endMs = startMs + Math.max(0, durationSeconds) * 1000;
        return Math.max(0, Math.floor((endMs - Date.now()) / 1000));
    };
    if (category) {
        url = `${window.location.origin}/api/auctions?category=${category}&count=${auctions_per_page}&offset=${auctions_offset}&sort=${sort_method}`;
    } else {
        url = `${window.location.origin}/api/auctions?count=${auctions_per_page}&offset=${auctions_offset}&sort=${sort_method}`;
    }
    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error("Response not ok: " + response.status);
        }
        auctions = await response.json();
        console.log(auctions);
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
            const placeholders =
                auctions_grid.querySelectorAll(placeholderSelector);
            placeholders.forEach((p) => p.closest(cardSelector)?.remove());
            removeEventListener("scroll");
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
                await fetch(
                    `${window.location.origin}/api/auctions/remove_published`,
                    {
                        method: "PUT",
                        headers: {
                            "Content-Type": "application/json",
                        },
                        body: JSON.stringify({ auction_id: auction.id }),
                    },
                );
            } catch (error) {
                console.error("Error updating auction status:", error);
            }
            continue; // Skip rendering this auction
        }

        const auctionCard = document.createElement("div");
        if (template === "index") {
            auctionCard.className = "item-card";
            auctionCard.innerHTML = `
          <div class="item-image" style="background-image: url('${auction.image_small}')"></div>
          <div class="item-details">
            <h3>${auction.name}</h3>
            <p class="item-date">${auction.published_at}</p>
            <p class="item-price">${auction.price} kr</p>
            <p class="item-status">Current bid</p>
          </div>
        `;
        } else {
            auctionCard.className = "auction-card";
            auctionCard.innerHTML = `
          <img src="${auction.image_small}" alt="Auction Image" class="item-image" />
          <div class="item-details">
            <h3>${auction.name}</h3>
            <p class="item-date">${auction.published_at}</p>
            <p class="item-price">${auction.price} kr</p>
            <p class="item-status">Current bid</p>
            <div class="auction-details">
              <span class="time-left">${formatTime(
                  remainingSeconds(auction.published_at, auction.auction_time),
              )}</span>
              <a href="/auctions/${auction.id}" class="btn-view">View</a>
            </div>
          </div>
        `;
            const timeLeftSpan = auctionCard.querySelector(".time-left");
            if (timeLeftSpan) {
                auctionElements.push({
                    element: timeLeftSpan,
                    published_at: auction.published_at,
                    auction_time: auction.auction_time,
                });
            }
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
            auctionElements.forEach(
                ({ element, published_at, auction_time }) => {
                    element.textContent = formatTime(
                        remainingSeconds(published_at, auction_time),
                    );
                },
            );
        }, 1000);
    }
    loadingByContainer.set(loadingKey, false);
    return auctions_offset;
};
