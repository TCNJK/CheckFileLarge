$(document).ready(function () {
    const searchInput = document.querySelector('.search-input');
    const suggestionsContainer = document.querySelector('.suggestions-container');
    $('#searchInput').on('input', function () {
        var keyword = $(this).val();

        $.ajax({
            url: '/SocialNetworkIRCNV/Search',
            type: 'GET',
            data: {keyword: keyword},
            success: function (data) {
                suggestionsContainer.innerHTML = "";

                showSearchResults(data);

            },
            error: function (xhr) {
                console.log('Lỗi khi gửi yêu cầu AJAX: ' + xhr.status);
            }
        });
    });

    function showSearchResults(results) {
        results.forEach(function (suggestion) {
            const suggestionHref = document.createElement('a');
            suggestionHref.classList.add('suggestion-href');
            //suggestionHref.setAttribute('href', suggestion.link_href);

            const suggestionItem = document.createElement('div');
            suggestionItem.classList.add('suggestion-item');
            suggestionItem.setAttribute('id', suggestion.UserID);
            suggestionItem.setAttribute('onclick', 'otherProfile(\'' + suggestion.UserID + '\')');
            const profilePic = document.createElement('img');
            profilePic.src = suggestion.img_user;
            suggestionHref.appendChild(profilePic);

            const name = document.createElement('span');
            name.textContent = suggestion.fullName;
            console.log('name: ' + suggestion.fullName);
            suggestionHref.appendChild(name);

            suggestionHref.insertAdjacentHTML('beforeend', '<br>');

            const mutualFriends = document.createElement('span');
            mutualFriends.classList.add('mutual-friends');
            mutualFriends.textContent = `${suggestion.mutual_friend} number friends`;
            suggestionHref.appendChild(mutualFriends);
            
            suggestionItem.appendChild(suggestionHref);
            suggestionItem.addEventListener('click', function () {
                searchInput.value = suggestion.fullName;
                
                suggestionsContainer.innerHTML = '';
            });

            suggestionsContainer.appendChild(suggestionItem);
        });
    }
});
