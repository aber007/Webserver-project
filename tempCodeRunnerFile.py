        session['current_user'] = {
            'id': user_obj.id,
            'firstName': user_obj.firstName,
            'lastName': user_obj.lastName,
            'email': user_obj.email,
            'city': user_obj.city,
            'accountCreated': user_obj.accountCreated
        }