document.addEventListener("DOMContentLoaded", function() {
    const publicToggleCheckbox = document.getElementById("public_toggle_checkbox");
  
    if (publicToggleCheckbox) {
      publicToggleCheckbox.addEventListener("change", function() {
        const recipeId = <%= @recipe.id %>;
        const isPublic = this.checked;
  
        // Send an AJAX request to update the "public" attribute
        fetch(`/recipes/${recipeId}/toggle_public?public=${isPublic}`, {
          method: "POST",
          headers: {
            "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
            "Content-Type": "application/json"
          },
        })
        .then(response => {
          if (response.ok) {
            return response.json();
          } else {
            throw new Error("Network response was not ok");
          }
        })
        .then(data => {
          // Handle the response data as needed, e.g., show a success message
          console.log(data);
        })
        .catch(error => {
          console.error("There was a problem with the fetch operation:", error);
        });
      });
    }
  });