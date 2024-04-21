import 'package:ecom_2/app/modules/UserAddProperty/controllers/user_add_property_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddPropertyView extends GetView<UserAddPropertyController> {
  const UserAddPropertyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final UserAddPropertyController controller =
        Get.put(UserAddPropertyController());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Property'),
          centerTitle: true,
        ),
        body: GetBuilder<UserAddPropertyController>(
            builder: (controller) => SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: controller.titleController,
                          decoration:
                              InputDecoration(labelText: 'Property Name'),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter the property name'
                              : null,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: controller.descriptionController,
                          decoration: InputDecoration(labelText: 'Description'),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: controller.priceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Price'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter the price' : null,
                        ),

                        DropdownButtonFormField<String>(
                          value: controller.selectedCategory,
                          onChanged: (newValue) =>
                              controller.selectedCategory = newValue,
                          items: controller.categoryItems,
                          decoration: InputDecoration(labelText: 'Category'),
                        ),

                        DropdownButtonFormField<String>(
                          value: controller.selectedType,
                          onChanged: (newValue) =>
                              controller.selectedType = newValue,
                          items: controller.typeItems,
                          decoration: InputDecoration(labelText: 'Type'),
                        ),

                        DropdownButtonFormField<String>(
                          value: controller.selectedLocation,
                          onChanged: (newValue) =>
                              controller.selectedLocation = newValue,
                          items: controller.locationItems,
                          decoration: InputDecoration(labelText: 'Location'),
                        ),
                        // Image Picker
                        controller.propertyImage == null ||
                                controller.imageBytes == null
                            ? ElevatedButton(
                                onPressed: controller.onPickImage,
                                child: const Text('Upload Image'))
                            : Image.memory(controller.imageBytes!),
                        SizedBox(height: 20),

                        // Toggle Buttons
                        Wrap(
                          children: PropertyType.values
                              .map((type) => ElevatedButton(
                                    onPressed: () =>
                                        controller.togglePropertyForm(type),
                                    child:
                                        Text(type.toString().split('.').last),
                                  ))
                              .toList(),
                        ),
                        SizedBox(height: 20),

                        // Conditional Property Forms
                        if (controller.showResidentialForm)
                          _buildResidentialForm(controller),
                        if (controller.showCommercialForm)
                          _buildCommercialForm(controller),
                        if (controller.showIndustrialForm)
                          _buildIndustrialForm(controller),
                        if (controller.showLandForm) _buildLandForm(controller),

                        ElevatedButton(
                          onPressed: () {
                            controller
                                .submitForm(controller.selectedPropertyType);
                          },
                          child: Text('Submit'),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                )));
  }

  Widget _buildResidentialForm(UserAddPropertyController controller) {
    return Column(
      children: [
        const Text("Residential Property"),
        TextFormField(
          controller: controller.bedroomsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Bedrooms'),
          validator: (value) =>
              value!.isEmpty ? 'Please enter number of bedrooms' : null,
        ),
        TextFormField(
          controller: controller.bathroomsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Bathrooms'),
        ),
        TextFormField(
          controller: controller.sizeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Size'),
        ),
        TextFormField(
          controller: controller.parkingSpacesResidentialController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Parking Spaces'),
        ),
      ],
    );
  }

  Widget _buildCommercialForm(UserAddPropertyController controller) {
    return Column(
      children: [
        const Text("Commercial Property"),
        TextFormField(
          controller: controller.floorAreaController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Floor Area'),
        ),
        TextFormField(
          controller: controller.parkingSpacesCommercialController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Parking Spaces'),
        ),
        TextFormField(
          controller: controller.buildingClassController,
          decoration: InputDecoration(labelText: 'Building Class'),
        ),
        TextFormField(
          controller: controller.tenantCapacityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Tenant Capacity'),
        ),
      ],
    );
  }

  Widget _buildIndustrialForm(UserAddPropertyController controller) {
    return Column(
      children: [
        const Text("Industrial Property"),
        TextFormField(
          controller: controller.industrialSizeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Size'),
        ),
        TextFormField(
          controller: controller.clearHeightController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Clear Height'),
        ),
        TextFormField(
          controller: controller.powerSupplyController,
          decoration: InputDecoration(labelText: 'Power Supply'),
        ),
      ],
    );
  }

  Widget _buildLandForm(UserAddPropertyController controller) {
    return Column(
      children: [
        TextFormField(
          controller: controller.landSizeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Size'),
          validator: (value) =>
              value!.isEmpty ? 'Please enter land size' : null,
        ),
      ],
    );
  }
}
