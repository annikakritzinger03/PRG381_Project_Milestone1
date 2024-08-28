<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome Pop-Up</title>
    <link rel="stylesheet" type="text/css" href="">
    <script type="text/javascript">
        function showModal() {
            var modal = document.getElementById("myModal");
            modal.style.display = "block";

        }

        function closeModal() {
            var modal = document.getElementById("myModal");
            window.location.href = 'index.jsp';
        }
    </script>
    <style>
        h2{
            font-family: "Space Mono", monospace;
        }

        p{
            font-family: Muli, sans-serif;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            padding-top: 100px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #fff;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 8px;
            position: relative;
            text-align: center;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .gif-container {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            overflow: hidden;
            background: linear-gradient(120deg, aquamarine, aqua);
            margin: 0 auto;
            position: absolute;
            top: 20%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .gif-container img {
            width: 100px;
            height: 100px;
            object-fit: cover;
        }

        .text-container{
            padding-top: 100px;
        }
    </style>
</head>
<body onload="showModal()">

<!-- Modal structure -->
<div id="myModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <div class="gif-container">
            <img src="https://media.giphy.com/media/Ke0nGk4YvxzJC/giphy.gif" alt="Welcome GIF">
        </div>
        <div class="text-container">
            <h2>Welcome <%= request.getAttribute("username") %></h2>
            <p>In the meantime, enjoy this digital handshake. Thank you for making it this far!</p>
        </div>
    </div>
</div>

</body>
</html>
