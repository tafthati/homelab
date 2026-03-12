// Portainer API Configuration (mantenuto per uso futuro con reverse proxy)
const PORTAINER_ENDPOINT_ID = 3;
const PORTAINER_API_KEY = "your_portainer_api_key_here";
const PORTAINER_BASE_URL = "https://192.XXX.X.XX:9443";

// BLOCCO COLLAPSE WIDGET - Intercetta click prima di Homepage
document.addEventListener('click', function(e) {
  const disclosureBtn = e.target.closest('button[id^="headlessui-disclosure-button"]');
  if (disclosureBtn) {
    e.preventDefault();
    e.stopPropagation();
    e.stopImmediatePropagation();
    return false;
  }
}, true);

function disableWidgetCollapse() {
  document.querySelectorAll('button[id^="headlessui-disclosure-button"]').forEach(btn => {
    btn.style.pointerEvents = 'none';
    btn.style.cursor = 'default';
    btn.onclick = (e) => { 
      e.preventDefault(); 
      e.stopPropagation(); 
      return false; 
    };
  });
}

const observer = new MutationObserver(disableWidgetCollapse);

function init() {
  disableWidgetCollapse();
  observer.observe(document.body, { childList: true, subtree: true });
}

if (document.readyState !== "loading") {
  init();
} else {
  document.addEventListener("DOMContentLoaded", init);
}

setInterval(disableWidgetCollapse, 2000);
