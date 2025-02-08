document.addEventListener("turbo:render", function () {
  const variantNamesDiv = document.getElementById("variant_names");
  const addVariantNameButton = document.getElementById("add-variant-name");

  // Initialize event listeners for existing variant names and values
  function initializeExistingVariantNames() {
    document
      .querySelectorAll(".variant-name-fields")
      .forEach((variantNameDiv) => {
        const variantNameId = variantNameDiv.getAttribute(
          "data-variant-name-id"
        );
        setupVariantValueAddRemove(variantNameDiv, variantNameId);

        // Initialize remove functionality for existing variant names
        variantNameDiv
          .querySelector(".remove-variant-name")
          ?.addEventListener("click", function (e) {
            e.preventDefault();
            const destroyField = variantNameDiv.querySelector(
              "[name$='[_destroy]']"
            );
            destroyField.value = "true"; // Mark for deletion
            variantNameDiv.style.display = "none"; // Hide the field
          });
      });
  }

  // Initialize event listeners for existing variant values
  function initializeExistingVariantValues() {
    document
      .querySelectorAll(".variant-value-fields")
      .forEach((variantValueDiv) => {
        variantValueDiv
          .querySelector(".remove-variant-value")
          ?.addEventListener("click", function (e) {
            e.preventDefault();
            const destroyField = variantValueDiv.querySelector(
              "[name$='[_destroy]']"
            );
            destroyField.value = "true"; // Mark for deletion
            variantValueDiv.style.display = "none"; // Hide the field
          });
      });
  }

  // Add Variant Name
  addVariantNameButton.addEventListener("click", function (e) {
    e.preventDefault();
    const timestamp = Date.now(); // Unique ID for new variant name
    const newVariantNameFields = document.createElement("div");
    newVariantNameFields.classList.add(
      "variant-name-fields",
      "space-y-4",
      "p-4",
      "border",
      "border-gray-300",
      "rounded-lg",
      "bg-gray-50"
    );
    newVariantNameFields.setAttribute("data-variant-name-id", timestamp);

    newVariantNameFields.innerHTML = `
      <input type="hidden" name="product[variant_names_attributes][${timestamp}][id]" id="product_variant_names_attributes_${timestamp}_id">
      <div class="field">
        <label for="product_variant_names_attributes_${timestamp}_name" class="block text-sm font-medium text-gray-700">Variant Name</label>
        <input type="text" name="product[variant_names_attributes][${timestamp}][name]" id="product_variant_names_attributes_${timestamp}_name" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
        <input type="hidden" name="product[variant_names_attributes][${timestamp}][_destroy]" class="destroy-field" value="false">
      </div>
      <div class="variant_values space-y-4" id="variant_values_${timestamp}"></div>
      <a href="#" class="add-variant-value inline-block bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600">Add Value</a>
      <a href="#" class="remove-variant-name inline-block bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600">Remove Variant</a>
    `;

    variantNamesDiv.appendChild(newVariantNameFields);
    setupVariantValueAddRemove(newVariantNameFields, timestamp);

    // Initialize remove functionality for the new variant name
    newVariantNameFields
      .querySelector(".remove-variant-name")
      ?.addEventListener("click", function (e) {
        e.preventDefault();
        const destroyField = newVariantNameFields.querySelector(
          "[name$='[_destroy]']"
        );
        destroyField.value = "true"; // Mark for deletion
        newVariantNameFields.style.display = "none"; // Hide the field
      });
  });

  // Add Variant Value
  function setupVariantValueAddRemove(variantNameDiv, variantNameId) {
    const addVariantValueButton =
      variantNameDiv.querySelector(".add-variant-value");
    const variantValuesDiv = variantNameDiv.querySelector(".variant_values");

    addVariantValueButton.addEventListener("click", function (e) {
      e.preventDefault();
      const timestamp = Date.now(); // Unique ID for new variant value

      const newVariantValueFields = document.createElement("div");
      newVariantValueFields.classList.add(
        "variant-value-fields",
        "space-y-4",
        "p-4",
        "border",
        "border-gray-300",
        "rounded-lg",
        "bg-gray-50"
      );
      newVariantValueFields.setAttribute("data-variant-value-id", timestamp);

      newVariantValueFields.innerHTML = `
        <input type="hidden" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${timestamp}][id]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_id">
        <div class="variant-value-container border p-4 rounded-md shadow-md bg-gray-100">
          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_value" class="block text-sm font-medium text-gray-700">Variant Value</label>
            <input type="text" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${timestamp}][value]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_value" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>
          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_price" class="block text-sm font-medium text-gray-700">Price</label>
            <input type="number" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${timestamp}][price]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_price" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>
          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_stock" class="block text-sm font-medium text-gray-700">Stock</label>
            <input type="number" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${timestamp}][stock]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_stock" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>
          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_image" class="block text-sm font-medium text-gray-700">Image</label>
            <input type="file" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${timestamp}][image]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${timestamp}_image" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>
          <input type="hidden" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${timestamp}][_destroy]" class="destroy-field" value="false">
          <a href="#" class="remove-variant-value inline-block bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600 mt-2">Remove Value</a>
        </div>
      `;

      variantValuesDiv.appendChild(newVariantValueFields);

      // Initialize remove functionality for the new variant value
      newVariantValueFields
        .querySelector(".remove-variant-value")
        ?.addEventListener("click", function (e) {
          e.preventDefault();
          const destroyField = newVariantValueFields.querySelector(
            "[name$='[_destroy]']"
          );
          destroyField.value = "true"; // Mark for deletion
          newVariantValueFields.style.display = "none"; // Hide the field
        });
    });
  }

  // Initialize event listeners for existing variant names and values
  initializeExistingVariantNames();
  initializeExistingVariantValues();
});
