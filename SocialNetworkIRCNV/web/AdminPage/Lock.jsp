<%-- 
    Document   : Lock
    Created on : Jun 18, 2023, 8:43:18 PM
    Author     : TCNJK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Set Lock Time</title>
    </head>
    <body onload="">
        <form action="../AddUserLock" method="GET">
            <table>
                <tr>
                    <td><label for="userId">UserID:</label></td>
                    <td><input type="text" id="userId" name="userId" readonly value="<%= request.getParameter("id")%>"></td>
                </tr>
                <tr>
                    <td><label for="day">Ngày:</label></td>
                    <td><input type="number" id="day" name="day" min="0" required value="0"></td>
                </tr>
                <tr>
                    <td><label for="hour">Giờ:</label></td>
                    <td><input type="number" id="hour" name="hour" min="0" max="23" required value="0"></td>
                </tr>
                <tr>
                    <td><label for="minute">Phút:</label></td>
                    <td><input type="number" id="minute" name="minute" min="0" max="59" required value="0"></td>
                </tr>
            </table>

            <button type="submit">Submit</button>
        </form>
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null && !message.isEmpty()) {%>
        <script>
            window.onload = function () {
                showAlert("<%= message%>");
                window.close();
            };
        </script>
        <% }%>


        <script>

            const dayInput = document.getElementById('day');
            const hourInput = document.getElementById('hour');
            const minuteInput = document.getElementById('minute');

            minuteInput.addEventListener('input', function () {
                if (parseInt(this.value) >= 60) {
                    let minutes = parseInt(this.value);
                    let hours = parseInt(hourInput.value) + Math.floor(minutes / 60);
                    minutes = minutes % 60;
                    let days = Math.floor(hours / 24);
                    hours = hours % 24;

                    dayInput.value = parseInt(dayInput.value) + days;
                    hourInput.value = hours;
                    this.value = minutes;
                }
            });

            hourInput.addEventListener('input', function () {
                if (parseInt(this.value) >= 24) {
                    dayInput.value = parseInt(dayInput.value) + Math.floor(parseInt(this.value) / 24);
                    this.value = parseInt(this.value) % 24;
                }
            });
        </script>

    </body>
</html>
