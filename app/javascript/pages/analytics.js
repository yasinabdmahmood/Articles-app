import { TabulatorFull } from "tabulator-tables"
import ldloader from "ldloader";


document.addEventListener("DOMContentLoaded", () => {
    const ldld = new ldloader({ root: "#my-loader" }); 

    const getHistoryObj = {
        url: "/getAnalytics",
        method: "GET",
        callback: (response) => {
            ldld.off();
            let table = new TabulatorFull("#analytics-table", {
                data: response.searches,
                layout: "fitColumns",
                height: "500px",
                columns: [
                  { title: "Text", field: "text", headerFilter: "input" },
                  { title: "count", field: "count"},

                ],
                
        });
              
            // Handle the response here
        },
        error: (err) => {
            console.error("Error:", err);
            // Handle the error here
        }
    };
    ldld.on();
    httpRequest(getHistoryObj);
});


function httpRequest({ url, method = "GET", data = {}, callback, error }) {
    // Prepare fetch options
    const options = {
        method: method.toUpperCase(),
        headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']")?.content || ""
        }
    };

    if(sessionStorage.getItem("session_id")) {
        options.headers["session_id"] = sessionStorage.getItem("session_id");
    }

    // Add body only if the method allows it
    if (["POST", "PUT", "PATCH", "DELETE"].includes(method.toUpperCase())) {
        options.body = JSON.stringify(data);
    } else {
        // For GET requests, append query params to URL
        const query = new URLSearchParams(data).toString();
        if (query) url += "?" + query;
    }

    // Make the fetch call
    fetch(url, options)
    .then(async response => {
      // ✅ First, read the headers from the response object
      const newSessionId = response.headers.get("session_id");
      if (newSessionId) {
        sessionStorage.setItem("session_id", newSessionId);
      }
  
      if (!response.ok) {
        const errorText = await response.text(); // helpful for debugging
        throw new Error(`HTTP error! Status: ${response.status} - ${errorText}`);
      }
  
      // ✅ Then parse the body
      return response.json();
    })
    .then(data => callback(data))
    .catch(err => {
      if (typeof error === "function") {
        error(err);
      } else {
        console.error("Request failed:", err);
      }
    });
  
}