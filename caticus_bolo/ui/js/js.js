// Function to toggle the dashboard visibility based on Lua messages
function ToggleDashboard(show) {
  var dashboard = document.querySelector('.caticus-bolo');
  if (show) {
      dashboard.classList.remove('hidden');
  } else {
      dashboard.classList.add('hidden');
  }
}

// Function to close the dashboard and notify the FiveM client
function closeDashboard() {
  fetch(`https://${GetParentResourceName()}/exit`, {
      method: 'POST',
      headers: {
          'Content-Type': 'application/json; charset=UTF-8',
      },
      body: JSON.stringify({})
  }).then(() => {
      console.log("Dashboard closed");
  }).catch(err => {
      console.error("Error closing dashboard:", err);
  });
}

document.addEventListener('DOMContentLoaded', function() {
  console.log("DOM fully loaded and parsed");

  window.addEventListener('message', function(event) {
      var item = event.data;
      if (item.type === "ui") {
          ToggleDashboard(item.status);
      }
  });

  // ESC key listener
  document.addEventListener('keydown', function (event) {
      if (event.key === "Escape") {
          console.log("Escape key pressed");
          closeDashboard();
      }
  });

  // Other event listeners and code here...
});



