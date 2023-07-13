var note = document.getElementById('title-header').innerHTML;
var title = document.title;
var titles = [note, title];
var currentIndex = 0;






// Lặp lại thay đổi tiêu đề sau mỗi giây
if (document.getElementById('title-header').innerHTML !== 'null')
{
    if(document.getElementById('title-header').innerHTML === 'null'){
        titles = [title];
    }
    setInterval(function () {
        // Thay đổi tiêu đề hiện tại
        document.title = titles[currentIndex];

        // Tăng chỉ số hiện tại và kiểm tra nếu nó vượt quá mảng tiêu đề
        currentIndex++;
        if (currentIndex >= titles.length) {
            currentIndex = 0;
        }
    }, 1000);
}