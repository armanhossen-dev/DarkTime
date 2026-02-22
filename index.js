let hr = document.getElementById("hr");
let min = document.getElementById("min");
let sec = document.getElementById("sec");
let ampm = document.getElementById("ampm");  //AM/PM 

let dateDisplay = document.getElementById("dateDisplay");

    setInterval(() => {
        let currentTime = new Date();
        
        // Get hours, minutes, seconds
        let hours = currentTime.getHours();
        let minutes = currentTime.getMinutes();
        let seconds = currentTime.getSeconds();

        // AM/PM Logic
        let amPm = hours >= 12 ? "PM" : "AM";
        hours = hours % 12;
        hours = hours ? hours : 12; // 0 should be shown as 12

        // Format : hour, minute, second to always have two digits
        hr.innerHTML = (hours < 10 ? "0" : "") + hours;
        min.innerHTML = (minutes < 10 ? "0" : "") + minutes;
        sec.innerHTML = (seconds < 10 ? "0" : "") + seconds;

        // Update AM/PM
        ampm.innerHTML = amPm;

        // Date logic
        let day = currentTime.getDate();
        let month = currentTime.getMonth() + 1; // Months are 0-indexed
        let year = currentTime.getFullYear();

        // Add leading zero if needed for day and month
        day = day < 10 ? "0" + day : day;
        month = month < 10 ? "0" + month : month;

        // Display date
        dateDisplay.innerHTML = `${day} . ${month} . ${year}`;
    }, 1000);
    
    function updateClock() {
    const now = new Date();
    let hour = now.getHours();
    const ampm = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12 || 12;

    document.getElementById('hr').textContent = hour;
    document.getElementById('hr').setAttribute("data-ampm", ampm);
    document.getElementById('ampm').textContent = ampm;

    document.getElementById('min').textContent = String(now.getMinutes()).padStart(2, '0');
    document.getElementById('sec').textContent = String(now.getSeconds()).padStart(2, '0');
}
setInterval(updateClock, 1000);
updateClock();

    function updateDay() {
    const dayDisplay = document.getElementById("dayDisplay");
    const days = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];
    const now = new Date();
    const dayName = days[now.getDay()];
    dayDisplay.textContent = dayName;
}
updateDay();    
