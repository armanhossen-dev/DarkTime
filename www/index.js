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

// Fullscreen Logic (optional - works on Android Chrome)
const hero = document.querySelector('.hero');
hero.addEventListener('dblclick', () => {
    if (!document.fullscreenElement) {
        hero.requestFullscreen().catch(err => console.error(err));
    } else {
        document.exitFullscreen();
    }
});

let hideTimeout;

function toggleSystemUI() {
    // Attempt to enter fullscreen (hides top status bar on most mobile browsers)
    if (!document.fullscreenElement) {
        document.documentElement.requestFullscreen().catch(e => {
            console.log("Fullscreen not supported or blocked");
        });
    }

    // Show visual elements (if you have a custom top bar in HTML)
    document.body.classList.remove('hide-ui');

    // Reset the 3-second timer
    clearTimeout(hideTimeout);
    hideTimeout = setTimeout(() => {
        document.body.classList.add('hide-ui');
        // Note: You can't programmatically exit fullscreen without user intent 
        // in most browsers, but we can hide all "on-screen" UI elements.
    }, 3000);
}

// Listen for any touch or click on the screen
document.addEventListener('touchstart', toggleSystemUI);
document.addEventListener('click', toggleSystemUI);