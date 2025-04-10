// app/javascript/pages/home.js

document.addEventListener("DOMContentLoaded", () => {
    const searchInput = document.getElementById("search-input");

    if (!searchInput) return;


    let timeoutId;

    searchInput.addEventListener("input", () => {
        clearTimeout(timeoutId); // Clear previous timer
        timeoutId = setTimeout(() => {
            // console.log("User typed:", searchInput.value);
            const httpobject = {
                url: "/search",
                method: "POST",
                data: { text: searchInput.value },
                callback: (articles) => {
                  const resultsDiv = document.getElementById("results");
                  resultsDiv.innerHTML = ""; // Clear previous results
          
                  if (articles.length === 0) {
                    resultsDiv.innerHTML = "<p>No articles found.</p>";
                    return;
                  }
          
                  // Loop through each article and display it
                  articles.forEach((article, index) => {
                    const articleElement = document.createElement("div");
                    articleElement.classList.add("article");
          
                    articleElement.innerHTML = `
                      <h3>${index + 1}. ${article.title}</h3>
                      <p>${article.content}</p>
                      <hr>
                    `;
          
                    resultsDiv.appendChild(articleElement);
                  });
                },
                error: (err) => {
                    console.error("Error:", err);
                    // Handle the error here
                }
            };

            httpRequest(httpobject);
        }, 1000); // 1000ms = 1 second delay
    });

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


