document.addEventListener("turbo:load", function () {
  let variantNameIdCounter = 0;
  let variantValueIdCounter = 0;

  const addVariantNameButton = document.getElementById("add-variant-name");
  const variantNamesDiv = document.getElementById("variant_names");

  addVariantNameButton.addEventListener("click", function (e) {
    e.preventDefault();
    variantNameIdCounter++;
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
    newVariantNameFields.setAttribute(
      "data-variant-name-id",
      variantNameIdCounter
    );

    newVariantNameFields.innerHTML = `
      <div class="field">
        <label for="product_variant_names_attributes_${variantNameIdCounter}_name" class="block text-sm font-medium text-gray-700">Variant Name</label>
        <input type="text" name="product[variant_names_attributes][${variantNameIdCounter}][name]" id="product_variant_names_attributes_${variantNameIdCounter}_name" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
        <input type="hidden" name="product[variant_names_attributes][${variantNameIdCounter}][_destroy]" id="product_variant_names_attributes_${variantNameIdCounter}__destroy">
      </div>

      <div class="variant_values space-y-4" id="variant_values_${variantNameIdCounter}"></div>

      <a href="#" class="add-variant-value inline-block bg-green-500 text-white px-4 py-2 rounded-md hover:bg-green-600">Add Value</a>
      <a href="#" class="remove-variant-name inline-block bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600">Remove Variant</a>
    `;

    variantNamesDiv.appendChild(newVariantNameFields);
    setupVariantValueAddRemove(newVariantNameFields, variantNameIdCounter);
  });

  variantNamesDiv.addEventListener("click", function (e) {
    if (e.target && e.target.classList.contains("remove-variant-name")) {
      e.preventDefault();
      e.target.closest(".variant-name-fields").remove();
    }
  });

  function setupVariantValueAddRemove(variantNameDiv, variantNameId) {
    const addVariantValueButton =
      variantNameDiv.querySelector(".add-variant-value");
    const variantValuesDiv = variantNameDiv.querySelector(".variant_values");

    addVariantValueButton.addEventListener("click", function (e) {
      e.preventDefault();
      variantValueIdCounter++;

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
      newVariantValueFields.setAttribute(
        "data-variant-value-id",
        variantValueIdCounter
      );

      newVariantValueFields.innerHTML = `
        <div class="variant-value-container border p-4 rounded-md shadow-md bg-gray-100">
          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_value" class="block text-sm font-medium text-gray-700">Variant Value</label>
            <input type="text" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${variantValueIdCounter}][value]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_value" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>

          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_price" class="block text-sm font-medium text-gray-700">Price</label>
            <input type="number" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${variantValueIdCounter}][price]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_price" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>

          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_stock" class="block text-sm font-medium text-gray-700">Stock</label>
            <input type="number" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${variantValueIdCounter}][stock]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_stock" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>

          <div class="field">
            <label for="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_image" class="block text-sm font-medium text-gray-700">Image</label>
            <input type="file" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${variantValueIdCounter}][image]" id="product_variant_names_attributes_${variantNameId}_variant_values_attributes_${variantValueIdCounter}_image" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          </div>

          <input type="hidden" name="product[variant_names_attributes][${variantNameId}][variant_values_attributes][${variantValueIdCounter}][_destroy]" class="destroy-field" value="false">

          <a href="#" class="remove-variant-value inline-block bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600 mt-2">Remove Value</a>
        </div>
      `;

      variantValuesDiv.appendChild(newVariantValueFields);

      newVariantValueFields
        .querySelector(".remove-variant-value")
        .addEventListener("click", function (e) {
          console.log("print bug");
          e.preventDefault();
          newVariantValueFields.remove();
        });
    });
  }
});
