/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

const quantityModal = document.getElementById('quantity-post-modal');
const priceModal = document.getElementById('price-post-modal');

quantityModal.addEventListener("change", (event) => {
    priceModal.innerHTML = 'Price: ' + quantityModal.value * 0.05 + '$';
    
});
function pay(budget){
    var cast= quantityModal.value * 0.05;
    if(cast> budget){
        alert('your budget is ['+budget+'$]\n'
            +'cannot pay for the fee of ['+cast+'$]');
        return;
    }
    var AID= document.getElementById('AID-pay').innerHTML;
    var BID= document.getElementById('BID-pay').innerHTML;
     $.ajax({
            url: "/SocialNetworkIRCNV/UpdateAds",
            type: "POST",
            data: {type: 'quantity', AID: AID, BID:BID, cast:cast, quantity: quantityModal.value},
            success: function (data) {
                if(confirm("Add more quantity successfull!!!")){
                    location.reload(true);
                }
                else{
                    location.reload(true);
                }
            },
            error: function (xhr) {
                console.log("?? x?y ra l?i: ");
                alert("Something wrong happen" + xhr);
            }
        });
    alert('!!!successfull pay ['+quantityModal.value * 0.05+'$]!!!');
}

function postAds(AdsID, BID) {
    var contentPost = document.getElementById('content-' + AdsID);
    var imagePost = document.getElementById('image-' + AdsID);
     var quantityAdsID = document.getElementById('quantity-' + AdsID);
    var status= document.getElementById('status-'+AdsID);
    
    var newStatus;
    if(status.innerHTML==="ongoing"){
        newStatus= 'inactive';
    }else if(status.innerHTML==='inactive'){
        newStatus= 'ongoing';
    }
    
    var content = document.getElementById('content-post-modal');
    var image = document.getElementById('image-post-modal');
    var quantity = document.getElementById('quantity');
    var AIDPay= document.getElementById('AID-pay');
    var BIDPay= document.getElementById('BID-pay');
    var postModal= document.getElementById('post-modal');
    

    quantity.innerHTML= 'Number quantity: ' +quantityAdsID.innerHTML;
    quantityModal.setAttribute('value', '');
    image.setAttribute('src', imagePost.getAttribute('src'));
    content.innerHTML = contentPost.innerHTML;
    AIDPay.innerHTML= AdsID;
    BIDPay.innerHTML= BID;
    postModal.setAttribute('onclick', 'newStatus(\''+AdsID+'\', \''+newStatus+'\', \''+quantityAdsID.innerHTML+ '\')');
    postModal.innerHTML= newStatus;
    
    $('#postAdsModal').modal('show');
}
function newStatus(AdsID, status, quantity){
    
    var text= "Are you sure to change status this ADS to "  + status + ' to advertise for others with ' +quantity+ ' time show';
    
    if(!confirm(text))
        return;
    $.ajax({
            url: "/SocialNetworkIRCNV/UpdateAds",
            type: "POST",
            data: {type:'status',AID: AdsID, status:status},
            success: function (data) {
                if(confirm(status+" successfull"))
                    location.reload(true);
                else location.reload(true);
            },
            error: function (xhr) {
                console.log("?? x?y ra l?i: ");
                alert("Something wrong happen" + xhr);
            }
        });
}
function viewAds(AdsID, BID) {
    var image = document.getElementById('image-' + AdsID);
    var content = document.getElementById('content-' + AdsID);
    var quantity = document.getElementById('quantity-' + AdsID);

    var saveChange = document.getElementById('save-change');
    var imgPost = document.getElementById('imgPost');
    var contentPost = document.getElementById('contentPost');
    var quantitymodalview= document.getElementById('num-quantity');
    
    quantitymodalview.innerHTML='Number quantity: ' +quantity.innerHTML;
    priceModal.innerHTML = 'Price: ' + quantityModal.value * 0.05 + '$';

    imgPost.setAttribute('src', image.getAttribute('src'));
    contentPost.innerHTML = content.innerHTML;
    saveChange.setAttribute('onclick', 'saveChange(\'' + AdsID + '\', \'' + BID + '\')');

    
    $('#viewAdsModal').modal('show');
}
function clearFileInput() {
    var imgPost = document.getElementById('imgPost');
    imgPost.setAttribute('src', '');
}

function saveChange(AdsID, BID) {
    if (!confirm("Are you sure to update Advertisement!!!"))
        return;
    var fileInput = document.querySelector('input[name="photoPost"]');
    var file = fileInput.files[0];
    var formData = new FormData();
    var content = document.getElementById("contentPost").value;
    var srcImage = document.getElementById('imgPost').getAttribute('src').trim();
    var quantity = document.getElementById('quantity-post-modal').value;
    formData.append('photo', file);
    formData.append('content', content);
    formData.append('quantity', quantity);
    formData.append('AID', AdsID);
    formData.append('BID', BID);
    if (srcImage === '')
        formData.append('type', 'clear');
    else
        formData.append('type', 'none');
    $.ajax({
        url: "/SocialNetworkIRCNV/UpdateAds",
        type: "POST",
        processData: false,
        contentType: false,
        data: formData,
        success: function (data) {
            var container = document.getElementById(AdsID);
            container.innerHTML = data;
            alert("!!!Update new Advertise successfull!!!");
        },
        error: function (xhr) {
            console.log("?? x?y ra l?i: ");
        }
    });
}
function DeleteAds(AID) {
    if(!confirm("!!!Delete advertisement successfull!!!"))
        return;
        $.ajax({
            url: "/SocialNetworkIRCNV/DeleteBusniness",
            type: "POST",
            data: {AID: AID},
            success: function (data) {
                var container = document.getElementById(AID);
                container.innerHTML = "";
                alert("!!!Delete Advertise successfull!!!");
            },
            error: function (xhr) {
                console.log("?? x?y ra l?i: ");
                alert("Something wrong happen" + xhr);
            }
        });
}