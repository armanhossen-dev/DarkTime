// Clock Logic
function updateClock() {
    const now = new Date();
    let hours = now.getHours();
    const minutes = now.getMinutes();
    const seconds = now.getSeconds();
    
    const amPm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12 || 12; 
    
    document.getElementById('hr').textContent = String(hours).padStart(2, '0');
    document.getElementById('min').textContent = String(minutes).padStart(2, '0');
    document.getElementById('sec').textContent = String(seconds).padStart(2, '0');
    document.getElementById('hr').setAttribute('data-ampm', amPm);
    
    const day = String(now.getDate()).padStart(2, '0');
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const year = now.getFullYear();
    document.getElementById('dateDisplay').textContent = `${day} . ${month} . ${year}`;
    
    const days = ['SUNDAY', 'MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY'];
    document.getElementById('dayDisplay').textContent = days[now.getDay()];
}

setInterval(updateClock, 1000);
updateClock();