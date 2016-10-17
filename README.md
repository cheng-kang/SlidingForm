# SlidingForm
SlidingForm generates sliding forms. This lib is written in Swift3.

## Usage

1. Customize Configuration
```
// e.g. change font
SlidingFormPageConfig.sharedInstance.customFontName = "Futura"
```

2. Create a sliding form and present it
```

let vc = SlidingFormViewController.vc(
    withFormTitle: "Settings",
    pages: [
        SlidingFormPage.getInput(withTitle: NSLocalizedString("Nickname", comment: "SlidingForm"), isRequired: true, desc: NSLocalizedString("Please enter your nickname.", comment: "SlidingForm"), defaultValue: NSLocalizedString("Default Nickname", comment: "SlidingForm"), errorMsg: "Cannot be empty!"),
        SlidingFormPage.getRatio(withTitle: "Gender", desc: nil, options: ["Male", "Female", "Other"], selectedOptionIndex: 0) ,
        SlidingFormPage.getTextarea(withTitle: "Self Description", isRequired: true, desc: NSLocalizedString("Describe yourself a little bit here.", comment: "SlidingForm"), defaultValue: nil, errorMsg: "Cannot be empty!"),
        SlidingFormPage.getSelect(withTitle: NSLocalizedString("Year of Birth", comment: "SlidingForm"), desc: nil, selectOptions: ["1994", "1993", "1992", "1991", "1990"], selectedOptionIndex: 2),
        SlidingFormPage.getInput(withTitle: "Four-Digit Code", isRequired: true, desc: NSLocalizedString("Please enter a four-digit code. Letters and numbers only.", comment: "SlidingForm"), defaultValue: nil, textRule: "[A-Za-z0-9]{4}", errorMsg: "The length should be 4. Use letters and numbers only."),
        SlidingFormPage.getCheckbox(withTitle: "Language Skills", desc: nil, options: ["Mandarin", "English", "Japanese", "Franch"], optionsDefaultValue: [true, true, false, false], selectionMin: 0, selectionMax: 4) ,
        SlidingFormPage.getSwitches(withTitle: "Enable Notifications", desc: nil, options: ["Local Notification", "Push Notification"], optionsDefaultValue: [true, true]) ,
        ]) { results in
            // some callback
            print(results)
            
            // In this case, it prints out. 
            // The rules of how results are constructed are specified in SlidingFormViewController.nextBtnClick()
            // ["Default Nickname", [0, "Male"], "A CUTE GUY!", [0, "1994"], "1024", [[true, true, false, false], ["Mandarin", "English", "Japanese", "Franch"]], [[true, false], ["Local Notification", "Push Notification"]]]
}
self.present(vc, animated: true, completion: nil)
```

## Screen Shots

### Input
<img src="./Simulator%20Screen%20Shot%202016%E5%B9%B410%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%884.45.48.png" width="250">

### Ratio
<img src="./Simulator%20Screen%20Shot%202016%E5%B9%B410%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%884.49.41.png" width="250">

### Text Area
<img src="./Simulator%20Screen%20Shot%202016%E5%B9%B410%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%884.49.54.png" width="250">

### Select
<img src="./Simulator%20Screen%20Shot%202016%E5%B9%B410%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%884.50.32.png" width="250">

### Input with Validation
<img src="./Simulator%20Screen%20Shot%202016%E5%B9%B410%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%884.51.01.png" width="250">

### Checkbox
<img src="./Simulator%20Screen%20Shot%202016%E5%B9%B410%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%884.52.10.png" width="250">

### Switch
<img src="./Simulator%20Screen%20Shot%202016%E5%B9%B410%E6%9C%8817%E6%97%A5%20%E4%B8%8B%E5%8D%884.52.15.png" width="250">
