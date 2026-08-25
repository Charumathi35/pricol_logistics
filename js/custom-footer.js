document.addEventListener("DOMContentLoaded", function() {
    // Wait a brief moment to ensure Elementor has initialized DOM
    setTimeout(function() {
        var logoContainer = document.querySelector(".elementor-element-4f2c9e7e > .elementor-widget-container");
        var linkedInIcon = document.querySelector(".elementor-element-faa69f1");
        var linkedInText = document.querySelector(".elementor-element-ce32f0f");
        
        if (logoContainer && linkedInIcon && linkedInText) {
            // Create a flex wrapper to hold both the icon and text horizontally
            var wrapper = document.createElement("div");
            wrapper.style.display = "flex";
            wrapper.style.alignItems = "center";
            wrapper.style.gap = "8px";
            wrapper.style.marginTop = "25px";
            
            // Move icon
            linkedInIcon.style.marginBottom = "0";
            wrapper.appendChild(linkedInIcon);
            
            // Move text
            var textSpan = linkedInText.querySelector(".elementor-heading-title");
            if(textSpan) {
                textSpan.style.position = "static";
                textSpan.style.display = "block";
                textSpan.style.marginTop = "0";
                textSpan.style.fontSize = "13px";
                wrapper.appendChild(textSpan);
            }
            
            // Append the flex wrapper under the main Pricol logo
            logoContainer.appendChild(wrapper);
            
            // Hide the old empty container
            linkedInText.style.display = "none";
        }
    }, 100);
});
