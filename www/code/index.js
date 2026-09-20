// 1. Clock Logic
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

// 2. Fullscreen Logic
function toggleFullScreenMode() {
    // 1. Native macOS WKWebView bridge (DMG app)
    if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.toggleFullScreen) {
        window.webkit.messageHandlers.toggleFullScreen.postMessage({});
        return;
    }

    // 2. Standard HTML5 Fullscreen API (Browsers, Windows, Mobile)
    const isFullScreen = document.fullscreenElement || document.webkitFullscreenElement || document.mozFullScreenElement;
    if (!isFullScreen) {
        const target = hero || document.documentElement;
        if (target.requestFullscreen) {
            target.requestFullscreen().catch(err => console.error(err));
        } else if (target.webkitRequestFullscreen) {
            target.webkitRequestFullscreen();
        } else if (target.mozRequestFullScreen) {
            target.mozRequestFullScreen();
        }
    } else {
        if (document.exitFullscreen) {
            document.exitFullscreen().catch(err => console.error(err));
        } else if (document.webkitExitFullscreen) {
            document.webkitExitFullscreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        }
    }
}

const hero = document.querySelector('.hero');
if (hero) {
    hero.addEventListener('dblclick', toggleFullScreenMode);
}

// 3. First-Time Visit Notification
// First-Time Visit Notification with Fade In/Out
window.addEventListener('DOMContentLoaded', () => {
    const hasVisited = localStorage.getItem('darktime_visited');

    if (!hasVisited) {
        // 1. Create the toast element
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.innerHTML = `<strong>Tip:</strong> Double-click to toggle Fullscreen mode.`;
        document.body.appendChild(toast);

        // 2. Fade In after 1 second
        setTimeout(() => {
            toast.classList.add('show');
        }, 1000);

        // 3. Fade Out after 6 seconds
        setTimeout(() => {
            toast.classList.remove('show');
            
            // Mark as visited after the first time
            localStorage.setItem('darktime_visited', 'true');
            
            // Optional: Remove from DOM entirely after fade finishes
            setTimeout(() => toast.remove(), 1000);
        }, 7000);
    }
});