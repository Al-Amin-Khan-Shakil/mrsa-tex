document.addEventListener("turbo:render", function () {
  const subDistrictsDiv = document.getElementById("sub_districts");
  const addSubDistrictButton = document.getElementById("add-sub-district");

  function initializeExistingSubDistrict() {
    document
      .querySelectorAll(".sub-district-fields")
      .forEach((subDistrictDiv) => {
        const subDistrictId = subDistrictDiv.getAttribute(
          "data-sub-district-id"
        );
        subDistrictDiv
          .querySelector(".remove-sub-district")
          ?.addEventListener("click", function (e) {
            e.preventDefault();
            const destroyField = subDistrictDiv.querySelector(
              "[name$= '[_destroy]']"
            );
            destroyField.value = "true";
            subDistrictDiv.style.display = "none";
          });
      });
  }

  if (addSubDistrictButton) {
    addSubDistrictButton.addEventListener("click", function (e) {
      e.preventDefault();
      const timestamp = Date.now();
      const newSubDistrictFields = document.createElement("div");
      newSubDistrictFields.classList.add(
        "sub-district-fields",
        "space-y-4",
        "p-4",
        "border",
        "border-gray-300",
        "rounded-lg",
        "bg-gray-50"
      );
      newSubDistrictFields.setAttribute("data-sub-district-id", timestamp);

      newSubDistrictFields.innerHTML = `
        <input type="hidden" name="district[sub_districts_attributes][${timestamp}][id]" id="district_sub_districts_attributes_${timestamp}_id">
        <div class="field">
          <label for="district_sub_districts_attributes_${timestamp}_name" class="block text-sm font-medium text-gray-700">Sub District</label>
          <input type="text" name="district[sub_districts_attributes][${timestamp}][name]" id="district_sub_districts_attributes_${timestamp}_name" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500">
          <input type="hidden" name="district[sub_districts_attributes][${timestamp}][_destroy]" class="destroy-fields" value="false">
        </div>
        <a href="#" class="remove-sub-district inline-block bg-red-500 text-white px-4 py-2 rounded-md hover:bg-red-600"> Remove Sub-District</a>
      `;

      subDistrictsDiv.appendChild(newSubDistrictFields);

      newSubDistrictFields
        .querySelector(".remove-sub-district")
        ?.addEventListener("click", function (e) {
          e.preventDefault();
          const destroyField = newSubDistrictFields.querySelector(
            "[name$= '[_destroy]']"
          );
          destroyField.value = "true";
          newSubDistrictFields.style.display = "none";
        });
    });
  }

  initializeExistingSubDistrict();
});
