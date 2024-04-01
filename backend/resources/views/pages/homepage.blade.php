<!doctype html>
<html lang="cs">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>TeamControl - mobile app for managing sport teams</title>
    @include('includes.head')
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap" rel="stylesheet">
    <style>
        * {
                     font-family: "Mulish", sans-serif;
                     font-optical-sizing: auto;
                     font-weight: 400;
                     font-style: normal;
                 }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="d-flex justify-content-center">
        <div class="d-flex flex-column text-center">
            <h1 class="display-1 mulish">TeamControl</h1>
            <p class="display-6">Mobile app for sports team management.</p>
        <div>
            <a class="btn btn-primary btn-lg" href="#download" role="button">Download</a>
        </div>
        </div>
    </div>
    <div class="section row justify-content-center gap-4 py-5">
        <div class="d-flex justify-content-center align-items-center col-xl-3 border border-secondary rounded" style="min-height: 350px">
            <div class="text-center">
                <svg height="80" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor"><path d="M2 13H8V21H2V13ZM16 8H22V21H16V8ZM9 3H15V21H9V3ZM4 15V19H6V15H4ZM11 5V19H13V5H11ZM18 10V19H20V10H18Z"></path></svg>
                <p class="display-6">Effortless Scheduling</p>
                <p>Streamline your team's schedule effortlessly. With TeamControl, you can plan practices, games, and events with a user-friendly calendar feature, eliminating the hassle of complex scheduling.</p>
            </div>
        </div>
        <div class="d-flex justify-content-center align-items-center col-xl-3 border border-secondary rounded" style="min-height: 350px">
            <div class="text-center pt-3">
                <svg height="80" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32"><g data-name="63-Communication"><path d="M31 2h-4v2h3v20H18a1 1 0 0 0-.71.29L13 28.59V25a1 1 0 0 0-1-1H2v-5H0v6a1 1 0 0 0 1 1h10v5a1 1 0 0 0 1.71.71l5.7-5.71H31a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1z"/><path d="M1 16h7v4a1 1 0 0 0 1.71.71l4.7-4.71H23a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1zM2 2h20v12h-8a1 1 0 0 0-.71.29L10 17.59V15a1 1 0 0 0-1-1H2z"/><path d="M11 7h2v2h-2zM15 7h2v2h-2zM7 7h2v2H7z"/></g></svg>
                <p class="display-6">Focused Communication</p>
                <p>Say goodbye to information overload. Our app keeps communication straightforward and to the point, focusing on delivering only the most important updates and announcements. No more sifting through unnecessary messages.</p>
            </div>
        </div>
        <div class="d-flex justify-content-center align-items-center col-xl-3 border border-secondary rounded" style="min-height: 350px">
            <div class="text-center">
                <svg height="80" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48"><g data-name="21-web designer"><path d="M43 48H5a5.006 5.006 0 0 1-5-5 1 1 0 0 1 1-1h46a1 1 0 0 1 1 1 5.006 5.006 0 0 1-5 5zM2.171 44A3.006 3.006 0 0 0 5 46h38a3.006 3.006 0 0 0 2.829-2z"/><path d="M19 43h10v2H19zM46 43h-2V14a1 1 0 0 0-1-1h-4v-2h4a3 3 0 0 1 3 3zM4 43H2V14a3 3 0 0 1 3-3h4v2H5a1 1 0 0 0-1 1z"/><path d="M6 36h37v2H6z"/><path d="M10 37H8V3a3 3 0 0 1 3-3h26a3 3 0 0 1 3 3v3h-2V3a1 1 0 0 0-1-1H11a1 1 0 0 0-1 1z"/><path d="M9 8h27v2H9z"/><path d="M26.648 25.176a1 1 0 0 1-.707-.293l-2.824-2.823a1 1 0 0 1 0-1.414L42.884.878a3.068 3.068 0 0 1 4.239 0 3 3 0 0 1 0 4.238L27.355 24.883a1 1 0 0 1-.707.293zm-1.41-3.823 1.41 1.409L45.708 3.7a1 1 0 0 0 0-1.41 1.019 1.019 0 0 0-1.409 0z"/><path d="M21 28a1 1 0 0 1-.895-1.447l2.824-5.648 1.789.895-1.482 2.964 2.964-1.483.9 1.789-5.653 2.83A1 1 0 0 1 21 28zM37.237 7.94l1.414-1.415 2.824 2.824-1.414 1.414zM38 12h2v25h-2zM12 4h2v2h-2zM16 4h2v2h-2zM20 4h2v2h-2zM17 22a5 5 0 1 1 5-5 5.006 5.006 0 0 1-5 5zm0-8a3 3 0 1 0 3 3 3 3 0 0 0-3-3z"/><path d="m19.293 19.707 1.414-1.414 3 3-1.413 1.415z"/><path d="M32 32H17a1 1 0 0 1-1-1V21h2v9h11.586l-4.295-4.3 1.414-1.414 6 6A1 1 0 0 1 32 32zM34 30h2v2h-2zM12 30h2v2h-2z"/></g></svg>
                <p class="display-6">Intuitive UI Design</p>
                <p>Experience a clean and user-friendly interface designed for easy navigation. We prioritize simplicity, ensuring that coaches and players can access critical information quickly and effortlessly.</p>
            </div>
        </div>
    </div>
    <div>
        <h4 class="display-5">About</h4>
        <p>
            This app is also my graduation project. It is free for everyone.
        </p>
    </div>
    <hr/>
    <div>
        <div class="d-flex flex-column py-3">
            <p class="mb-0">Links:</p>
            <s><a href="#">Documentation (.pdf) - CZECH</a></s> <p> after maturita gonna go public </p>
            <s><a href="#">Google Play store</a></s> <p>testing</p>
        </div>
        <div class="d-flex flex-column py-3" id="download">
            <p class="mb-0">Download:</p>
            <a href="https://drive.google.com/drive/folders/17AWYcOnv_b-c8FIhgzJtDq2MhsxM_u_h" target="_blank">Latest Build | 0.0.2 | .APK</a>
        </div>
    </div>
</div>
</body>
</html>
