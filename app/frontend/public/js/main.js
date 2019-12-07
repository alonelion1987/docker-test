function getXmlHttp() {
    let xmlhttp;
    try {
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
        try {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (E) {
            xmlhttp = false;
        }
    }
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
        xmlhttp = new XMLHttpRequest();
    }
    return xmlhttp;
}

function postToServerAsync(route, queryString, callback) {
    let request = getXmlHttp();

    request.open('POST', route, true);
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.send(queryString);

    request.onreadystatechange = function () {
        if (request.readyState === 4 && request.status === 200) {
            callback(request.responseText);
        }
    };
}

function onLoad() {
    let buttonCreateMessage = document.getElementById('button-create-message');
    let message = document.getElementById('message');
    let methods = document.getElementsByName('method');
    let resultArea = document.getElementById('result');

    buttonCreateMessage.addEventListener('click', function () {
        if (message.value) {
            let method = null;
            for (let i = 0, length = methods.length; i < length; i++) {
                if (methods[i].checked) {
                    method = methods[i].value;
                    break;
                }
            }
            let queryString = `message=${encodeURIComponent(message.value)}&method=${method}`;
            postToServerAsync('/api/encode_message', queryString, function (responseText) {
                resultArea.textContent = JSON.parse(responseText).encodedMessage;
            });
        }
    });
}

document.addEventListener('DOMContentLoaded', onLoad);
