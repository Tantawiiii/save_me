

import 'package:flutter/material.dart';

import '../../../main.dart';


class Language extends ChangeNotifier {
  Language._privateConstructor();

  static final Language _instance = Language._privateConstructor();

  static Language get instance => _instance;

  String? _lang = language;

  getLanguage() {
    return _lang;
  }

  setLanguage(String lang) {
    _lang = lang;
  }

  API_KEY_Google() {
    if (getLanguage() == 'EN') {
      return "AIzaSyB_wFmdtRx-M0XdqAEpHF2vCfV2oWT9VC8";
    } else if (getLanguage() == 'DE') {
      return "AIzaSyB_wFmdtRx-M0XdqAEpHF2vCfV2oWT9VC8";
    }
  }

  txtGetStarted() {
    if (getLanguage() == 'EN') {
      return "Get Started";
    } else if (getLanguage() == 'DE') {
      return "Loslegen";
    }
  }

  txtWelcomeLogin() {
    if (getLanguage() == 'EN') {
      return "Welcome Back!";
    } else if (getLanguage() == 'DE') {
      return "Willkommen zurück!";
    }
  }

  txtWelcomeLogin2() {
    if (getLanguage() == 'EN') {
      return "Log in to SaveMe to connect to your network!";
    } else if (getLanguage() == 'DE') {
      return "Jetzt bei SaveMee anmelden und dein Netzwerk zu aktivieren!";
    }
  }

  txtEmail() {
    if (getLanguage() == 'EN') {
      return "Email";
    } else if (getLanguage() == 'DE') {
      return "E-Mail";
    }
  }

  txtHintEmail() {
    if (getLanguage() == 'EN') {
      return "Enter your email";
    } else if (getLanguage() == 'DE') {
      return "Gib deine E-Mail-Adresse ein";
    }
  }

  txtIsEmptyEmail() {
    if (getLanguage() == 'EN') {
      return "Please enter a valid email address.";
    } else if (getLanguage() == 'DE') {
      return "Bitte geben Sie eine gültige E-Mail-Adresse ein";
    }
  }

  txtNotValidEmail() {
    if (getLanguage() == 'EN') {
      return "Your Email is not a valid address.";
    } else if (getLanguage() == 'DE') {
      return "Ihre E-Mail-Adresse ist keine gültige Adresse.";
    }
  }

  txtPassword() {
    if (getLanguage() == 'EN') {
      return "Password";
    } else if (getLanguage() == 'DE') {
      return "Passwort";
    }
  }

  txtHintPassword() {
    if (getLanguage() == 'EN') {
      return "Enter your password";
    } else if (getLanguage() == 'DE') {
      return "Passwort eingeben";
    }
  }

  txtConfirmPassword() {
    if (getLanguage() == 'EN') {
      return "Confirm Password";
    } else if (getLanguage() == 'DE') {
      return "Passwort bestätigen";
    }
  }

  txtCreatePassword() {
    if (getLanguage() == 'EN') {
      return "Create a Password";
    } else if (getLanguage() == 'DE') {
      return "Passwort erstellen";
    }
  }

  txtHintConfirmPassword() {
    if (getLanguage() == 'EN') {
      return "re-enter your password";
    } else if (getLanguage() == 'DE') {
      return "die Eingabe eines Passwortes";
    }
  }

  txtNotMatchPassword() {
    if (getLanguage() == 'EN') {
      return "The password does not match.";
    } else if (getLanguage() == 'DE') {
      return "Das Passwort stimmt nicht überein.";
    }
  }

  txtPasswordMatch() {
    if (getLanguage() == 'EN') {
      return "must have at least {8 , A/a ,!@# } characters.";
    } else if (getLanguage() == 'DE') {
      return "Das Passwort muss mindestens aus 6 Zeichen.";
    }
  }

  txtChangePassword() {
    if (getLanguage() == 'EN') {
      return "Change Password";
    } else if (getLanguage() == 'DE') {
      return "Kennwort ändern";
    }
  }

  txtHintNewPassword() {
    if (getLanguage() == 'EN') {
      return "Create a new password";
    } else if (getLanguage() == 'DE') {
      return "Erstelle ein neues Passwort";
    }
  }

  txtHintOldPassword() {
    if (getLanguage() == 'EN') {
      return "Enter the old password";
    } else if (getLanguage() == 'DE') {
      return "Geben Sie das alte Passwort ein";
    }
  }

  txtHintConfirmNewPassword() {
    if (getLanguage() == 'EN') {
      return "Confirm a new password";
    } else if (getLanguage() == 'DE') {
      return "Bestätigen Sie ein neues Passwort";
    }
  }

  txtButtonLogin() {
    if (getLanguage() == 'EN') {
      return "Log In";
    } else if (getLanguage() == 'DE') {
      return "Einloggen";
    }
  }

  txtDoNotHaveAcc() {
    if (getLanguage() == 'EN') {
      return "Don't have an account?";
    } else if (getLanguage() == 'DE') {
      return "Noch kein Konto?";
    }
  }

  txtButtonRegister() {
    if (getLanguage() == 'EN') {
      return "Register";
    } else if (getLanguage() == 'DE') {
      return "Registrieren";
    }
  }

  txtWelcomeRegister() {
    if (getLanguage() == 'EN') {
      return "Get Started with SaveMee";
    } else if (getLanguage() == 'DE') {
      return "Starte mit SaveMee";
    }
  }

  txtWelcomeRegister2() {
    if (getLanguage() == 'EN') {
      return "Register now to keep in touch and for peace of mind.";
    } else if (getLanguage() == 'DE') {
      return "Registrieren Sie sich jetzt, um in Kontakt zu bleiben und beruhigt zu sein.";
    }
  }

  txtName() {
    if (getLanguage() == 'EN') {
      return "Name";
    } else if (getLanguage() == 'DE') {
      return "Name";
    }
  }

  txtHintName() {
    if (getLanguage() == 'EN') {
      return "Your Name";
    } else if (getLanguage() == 'DE') {
      return "Ihr Name";
    }
  }

  txtIsEmptyName() {
    if (getLanguage() == 'EN') {
      return "Please enter name";
    } else if (getLanguage() == 'DE') {
      return "Bitte Namen eingeben";
    }
  }

  txtUserName() {
    if (getLanguage() == 'EN') {
      return "My Name";
    } else if (getLanguage() == 'DE') {
      return "Meine Name";
    }
  }

  txtHintUserName() {
    if (getLanguage() == 'EN') {
      return "Enter your username";
    } else if (getLanguage() == 'DE') {
      return "Benutzername eingeben";
    }
  }

  txtIsEmptyUserName() {
    if (getLanguage() == 'EN') {
      return "Tantawii";
    } else if (getLanguage() == 'DE') {
      return "Tantawii";
    }
  }

  txtPhoneNumber() {
    if (getLanguage() == 'EN') {
      return "Phone Number";
    } else if (getLanguage() == 'DE') {
      return "Telefonnummer";
    }
  }

  txtHintPhoneNumber() {
    if (getLanguage() == 'EN') {
      return "Enter your phone number";
    } else if (getLanguage() == 'DE') {
      return "Telefonnummer eingeben";
    }
  }

  txtHintLocation() {
    if (getLanguage() == 'EN') {
      return "Enter choose return location";
    } else if (getLanguage() == 'DE') {
      return "Meine Lokation bestätigen";
    }
  }

  txtLocation() {
    if (getLanguage() == 'EN') {
      return "Choose Return Location";
    } else if (getLanguage() == 'DE') {
      return "Meine Lokation auswählen";
    }
  }

  txtBtnSubmit() {
    if (getLanguage() == 'EN') {
      return "Submit";
    } else if (getLanguage() == 'DE') {
      return "Einreichen";
    }
  }

  txtHaveAcc() {
    if (getLanguage() == 'EN') {
      return "Already have an account?";
    } else if (getLanguage() == 'DE') {
      return "Bereits ein Konto vorhanden?";
    }
  }

  txtBtnLogin() {
    if (getLanguage() == 'EN') {
      return "Log In";
    } else if (getLanguage() == 'DE') {
      return "Einloggen";
    }
  }

  txtLogOut() {
    if (getLanguage() == 'EN') {
      return "Logout";
    } else if (getLanguage() == 'DE') {
      return "Ausloggen";
    }
  }

  txtProfileInfo() {
    if (getLanguage() == 'EN') {
      return "Profile Information is Empty";
    } else if (getLanguage() == 'DE') {
      return "Profilinformationen sind leer";
    }
  }
  txtStartAddProfile() {
    if (getLanguage() == 'EN') {
      return "Start Adding Profiles +";
    } else if (getLanguage() == 'DE') {
      return "Hinzufügen von Profilen starten + ";
    }
  }

  txtAddProfile() {
    if (getLanguage() == 'EN') {
      return "Add Profile";
    } else if (getLanguage() == 'DE') {
      return "Profil hinzufügen";
    }
  }

  txtItemHomeMenu() {
    if (getLanguage() == 'EN') {
      return "Home";
    } else if (getLanguage() == 'DE') {
      return "Heim";
    }
  }

  txtItemLogoutMenu() {
    if (getLanguage() == 'EN') {
      return "Log Out";
    } else if (getLanguage() == 'DE') {
      return "Ausloggen";
    }
  }

  txtChooseProfile() {
    if (getLanguage() == 'EN') {
      return "Choose Your Profile Type: ";
    } else if (getLanguage() == 'DE') {
      return "Wählen Sie Ihren Profiltyp:";
    }
  }

  txtType() {
    if (getLanguage() == 'EN') {
      return "Type";
    } else if (getLanguage() == 'DE') {
      return "Typ";
    }
  }

  txtNext() {
    if (getLanguage() == 'EN') {
      return "Next";
    } else if (getLanguage() == 'DE') {
      return "Weiter";
    }
  }

  txtCreate() {
    if (getLanguage() == 'EN') {
      return "Create";
    } else if (getLanguage() == 'DE') {
      return "Erstellen";
    }
  }


  txtCancel() {
    if (getLanguage() == 'EN') {
      return "Cancel";
    } else if (getLanguage() == 'DE') {
      return "Abbrechen";
    }
  }

  txtKidBasicInfo() {
    if (getLanguage() == 'EN') {
      return "Child Basic Details";
    } else if (getLanguage() == 'DE') {
      return "Grundlegende Details zum Kind";
    }
  }
  txtBasicInfoHint() {
    if (getLanguage() == 'EN') {
      return "Please add your child information";
    } else if (getLanguage() == 'DE') {
      return "Daten des Kindes eingeben";
    }
  }

  txtDatePattern() {
    if (getLanguage() == 'EN') {
      return "yyyy-MM-dd";
    } else if (getLanguage() == 'DE') {
      return "yyyy-MM-dd";
    }
  }

  txtBirthday() {
    if (getLanguage() == 'EN') {
      return "Birthday";
    } else if (getLanguage() == 'DE') {
      return "Geburtstag";
    }
  }

  txtHintBirthday() {
    if (getLanguage() == 'EN') {
      return "yyyy-mm-dd";
    } else if (getLanguage() == 'DE') {
      return "yyyy-mm-dd";
    }
  }

  txtAge() {
    if (getLanguage() == 'EN') {
      return "Age";
    } else if (getLanguage() == 'DE') {
      return "Alter";
    }
  }

  txtKidAgeHint() {
    if (getLanguage() == 'EN') {
      return "Enter your child's age";
    } else if (getLanguage() == 'DE') {
      return " das Alter Ihres Kindes ein";
    }
  }

  txtSize() {
    if (getLanguage() == 'EN') {
      return "Size";
    } else if (getLanguage() == 'DE') {
      return "Größe";
    }
  }

  txtWeight() {
    if (getLanguage() == 'EN') {
      return "Weight";
    } else if (getLanguage() == 'DE') {
      return "Gewicht";
    }
  }

  txtKg() {
    if (getLanguage() == 'EN') {
      return "Kg";
    } else if (getLanguage() == 'DE') {
      return "Kg";
    }
  }

  txtHeight() {
    if (getLanguage() == 'EN') {
      return "Height";
    } else if (getLanguage() == 'DE') {
      return "Höhe";
    }
  }
  txtCm() {
    if (getLanguage() == 'EN') {
      return "Cm";
    } else if (getLanguage() == 'DE') {
      return "Cm";
    }
  }

  txtKidBodyInfo() {
    if (getLanguage() == 'EN') {
      return "Child Body Shape Information's";
    } else if (getLanguage() == 'DE') {
      return "Informationen zur Körperform.";
    }
  }

  txtBodyInfoHint() {
    if (getLanguage() == 'EN') {
      return "Here We Write Body Information First";
    } else if (getLanguage() == 'DE') {
      return "Hier schreiben wir zuerst die Körperinformationen";
    }
  }

  txtCharacteristics() {
    if (getLanguage() == 'EN') {
      return "Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Merkmale";
    }
  }

  txtHintCharacteristics() {
    if (getLanguage() == 'EN') {
      return "Enter Your child Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Merkmale eingeben.";
    }
  }

  txtSpecialChar() {
    if (getLanguage() == 'EN') {
      return "Special Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Besondere Charakteristiken";
    }
  }

  txtHintSpecialChar() {
    if (getLanguage() == 'EN') {
      return "Enter Your child Special Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Besondere Merkmale eingeben.";
    }
  }

  txtBehavior() {
    if (getLanguage() == 'EN') {
      return "Behavior";
    } else if (getLanguage() == 'DE') {
      return "Verhalten";
    }
  }

  txtHintBehavior() {
    if (getLanguage() == 'EN') {
      return "Enter Your child Behavior";
    } else if (getLanguage() == 'DE') {
      return "Verhalten eingeben.";
    }
  }

  txtHealthInfo() {
    if (getLanguage() == 'EN') {
      return "child Medical Profile";
    } else if (getLanguage() == 'DE') {
      return "Kind Medizinisches Profil";
    }
  }

  txtDiet() {
    if (getLanguage() == 'EN') {
      return "Diet";
    } else if (getLanguage() == 'DE') {
      return "Ernährung";
    }
  }

  txtHintDiet() {
    if (getLanguage() == 'EN') {
      return "Enter your child diet";
    } else if (getLanguage() == 'DE') {
      return "Spezielle Ernährung eingeben.";
    }
  }

  txtAllergies() {
    if (getLanguage() == 'EN') {
      return "Allergies";
    } else if (getLanguage() == 'DE') {
      return "Allergien";
    }
  }

  txtHintAllergies() {
    if (getLanguage() == 'EN') {
      return "Enter your child allergies";
    } else if (getLanguage() == 'DE') {
      return "Allergien eingeben.";
    }
  }

  txtDiseases() {
    if (getLanguage() == 'EN') {
      return "Diseases";
    } else if (getLanguage() == 'DE') {
      return "Krankheiten";
    }
  }

  txtHitDiseases() {
    if (getLanguage() == 'EN') {
      return "Enter your child diseases";
    } else if (getLanguage() == 'DE') {
      return "Krankheiten eingeben.";
    }
  }

  txtMedicines() {
    if (getLanguage() == 'EN') {
      return "Medication";
    } else if (getLanguage() == 'DE') {
      return "Medikamente";
    }
  }

  txtHintMedicines() {
    if (getLanguage() == 'EN') {
      return "Enter your child medication";
    } else if (getLanguage() == 'DE') {
      return "Medikamente eingeben";
    }
  }

  txtAdditionInfo() {
    if (getLanguage() == 'EN') {
      return "Addition Information";
    } else if (getLanguage() == 'DE') {
      return "Zusätzliche Informationen";
    }
  }

  txtHintAdditionInfo() {
    if (getLanguage() == 'EN') {
      return "Enter your child addition information";
    } else if (getLanguage() == 'DE') {
      return "Zusätzliche Informationen hinzufügen.";
    }
  }

  txtAppBarHome() {
    if (getLanguage() == 'EN') {
      return "Hello! Anonymous";
    } else if (getLanguage() == 'DE') {
      return "Hallo! Anonym";
    }
  }

  txtAppBarWelcome() {
    if (getLanguage() == 'EN') {
      return "Welcome to SaveMee";
    } else if (getLanguage() == 'DE') {
      return "Willkommen bei SaveMee";
    }
  }

  txtHomeTab() {
    if (getLanguage() == 'EN') {
      return "Home";
    } else if (getLanguage() == 'DE') {
      return "Heim";
    }
  }

  txtProfileTab() {
    if (getLanguage() == 'EN') {
      return "Profile";
    } else if (getLanguage() == 'DE') {
      return "Profil";
    }
  }

  txtLocationTab() {
    if (getLanguage() == 'EN') {
      return "Location";
    } else if (getLanguage() == 'DE') {
      return "Standort";
    }
  }

  txtSettingsTab() {
    if (getLanguage() == 'EN') {
      return "Settings";
    } else if (getLanguage() == 'DE') {
      return "Einstellungen";
    }
  }

  txtEnglish() {
    if (getLanguage() == 'EN') {
      return "English";
    } else if (getLanguage() == 'DE') {
      return "English";
    }
  }

  txtGermany() {
    if (getLanguage() == 'EN') {
      return "Deutsch";
    } else if (getLanguage() == 'DE') {
      return "Deutsch";
    }
  }

  txtAvatarOrPhoto() {
    if (getLanguage() == 'EN') {
      return "Select your avatar or upload a photo";
    } else if (getLanguage() == 'DE') {
      return "Wählen Sie Ihren Avatar aus oder laden Sie ein Foto hoch";
    }
  }

  txtAddInfo() {
    if (getLanguage() == 'EN') {
      return "Additional Information";
    } else if (getLanguage() == 'DE') {
      return "Zusätzliche Informationen";
    }
  }

  txtKidCard() {
    if (getLanguage() == 'EN') {
      return "Child Profile";
    } else if (getLanguage() == 'DE') {
      return "Kinderprofil";
    }
  }

  txtKidCardHint() {
    if (getLanguage() == 'EN') {
      return "Please add your child information";
    } else if (getLanguage() == 'DE') {
      return "Daten des Kindes eingeben";
    }
  }

  txtPhoto() {
    if (getLanguage() == 'EN') {
      return "Photo";
    } else if (getLanguage() == 'DE') {
      return "Foto";
    }
  }

  txtCreatedDone() {
    if (getLanguage() == 'EN') {
      return "You have just created a Successful profile.";
    } else if (getLanguage() == 'DE') {
      return "Profil erfolgreich erstellt!";
    }
  }

  txtCreatedNewBtn() {
    if (getLanguage() == 'EN') {
      return "Create New Profile";
    } else if (getLanguage() == 'DE') {
      return "Neues Profil erstellen";
    }
  }

  txtBackToHomeBtn() {
    if (getLanguage() == 'EN') {
      return "Back To Home";
    } else if (getLanguage() == 'DE') {
      return "Zurück Startseite";
    }
  }

  txtRegisterNow() {
    if (getLanguage() == 'EN') {
      return "Register Now";
    } else if (getLanguage() == 'DE') {
      return "Jetzt registrieren";
    }
  }


  txtCompleteProfile() {
    if (getLanguage() == 'EN') {
      return "Complete Profile";
    } else if (getLanguage() == 'DE') {
      return "Profil ergänzen";
    }
  }

  txtSkip() {
    if (getLanguage() == 'EN') {
      return "Skip";
    } else if (getLanguage() == 'DE') {
      return "Überspringen";
    }
  }

  txtRestCancel() {
    if (getLanguage() == 'EN') {
      return "Reset and Cancel";
    } else if (getLanguage() == 'DE') {
      return "Zurücksetzen und Abbrechen";
    }
  }

  txtUpdate() {
    if (getLanguage() == 'EN') {
      return "Update";
    } else if (getLanguage() == 'DE') {
      return "Aktualisieren";
    }
  }

  txtHintReturnLocation() {
    if (getLanguage() == 'EN') {
      return "Holzmarktstraße 51, 10243 Berlin";
    } else if (getLanguage() == 'DE') {
      return "Holzmarktstraße 51, 10243 Berlin";
    }
  }

  txtReturnLocation() {
    if (getLanguage() == 'EN') {
      return "Choose Return Location";
    } else if (getLanguage() == 'DE') {
      return "Wählen Sie Rückgabeort";
    }
  }

  txtDragLocation() {
    if (getLanguage() == 'EN') {
      return "Or drag and select your location manually";
    } else if (getLanguage() == 'DE') {
      return "Oder ziehen Sie Ihren Standort und wählen Sie ihn manuell aus";
    }
  }

  txtBottomDialog() {
    if (getLanguage() == 'EN') {
      return "The profile has been updated";
    } else if (getLanguage() == 'DE') {
      return "Das Profil wurde aktualisiert";
    }
  }

  txtBtnRef() {
    if (getLanguage() == 'EN') {
      return "Refresh";
    } else if (getLanguage() == 'DE') {
      return "Aktualisierung";
    }
  }

  txtPleaseCheck() {
    if (getLanguage() == 'EN') {
      return "Please check your connection. When you’re back online refresh the page or hit the button below.";
    } else if (getLanguage() == 'DE') {
      return "Bitte überprüfen Sie Ihre Verbindung. Wenn Sie wieder online sind, aktualisieren Sie die Seite oder klicken Sie auf die Schaltfläche unten.";
    }
  }

  txtOffline() {
    if (getLanguage() == 'EN') {
      return "You’re Currently Offline";
    } else if (getLanguage() == 'DE') {
      return "Sie sind derzeit offline";
    }
  }

  txtSeniorCard() {
    if (getLanguage() == 'EN') {
      return "Senior Profile";
    } else if (getLanguage() == 'DE') {
      return "Seniorenprofil";
    }
  }

  txtSeniorCardHint() {
    if (getLanguage() == 'EN') {
      return "Please add senior’s information.";
    } else if (getLanguage() == 'DE') {
      return "Daten der Person eingeben.";
    }
  }

  txtSeniorBasicInfo() {
    if (getLanguage() == 'EN') {
      return "Senior Basic Details";
    } else if (getLanguage() == 'DE') {
      return "Basisdaten";
    }
  }

  txtHintUserSenior() {
    if (getLanguage() == 'EN') {
      return "Enter senior name";
    } else if (getLanguage() == 'DE') {
      return "Bitte Name eingeben";
    }
  }

  txtSeniorAgeHint() {
    if (getLanguage() == 'EN') {
      return "Enter senior age";
    } else if (getLanguage() == 'DE') {
      return "Bitte Alter eingeben";
    }
  }

  txtSeniorBodyInfo() {
    if (getLanguage() == 'EN') {
      return "Senior Body Shape Information";
    } else if (getLanguage() == 'DE') {
      return "Informationen zur Körperform";
    }
  }

  txtSeniorHintCharacteristics() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Merkmale eingeben";
    }
  }

  txtSeniorHintSpecialChar() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s Special Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Besondere Merkmale eingeben";
    }
  }

  txtSeniorHintBehavior() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s Behaviour";
    } else if (getLanguage() == 'DE') {
      return "Verhalten eingeben";
    }
  }

  txtSeniorHealthInfo() {
    if (getLanguage() == 'EN') {
      return "Senior Medical Profile";
    } else if (getLanguage() == 'DE') {
      return "Senior Medizinisches Profil";
    }
  }

  txtSeniorHintDiet() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s diet";
    } else if (getLanguage() == 'DE') {
      return "Spezielle Ernährung eingeben.";
    }
  }

  txtSeniorHintAllergies() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s allergies";
    } else if (getLanguage() == 'DE') {
      return "Allergien eingeben";
    }
  }

  txtSeniorHitDiseases() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s diseases";
    } else if (getLanguage() == 'DE') {
      return "Krankheiten eingeben.";
    }
  }

  txtSeniorHintMedicines() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s medication";
    } else if (getLanguage() == 'DE') {
      return "Medikamente eingeben";
    }
  }
  txtSeniorHintAdditionInfo() {
    if (getLanguage() == 'EN') {
      return "Enter Senior’s addition information";
    } else if (getLanguage() == 'DE') {
      return "Zusätzliche Informationen hinzufügen.";
    }
  }
  txtSeniorHome() {
    if (getLanguage() == 'EN') {
      return "Senior’s Home";
    } else if (getLanguage() == 'DE') {
      return "Seniorenheim";
    }
  }
  txtSeniorHomeInfo() {
    if (getLanguage() == 'EN') {
      return "If senior lives in a special institute, Please enter the following data: ";
    } else if (getLanguage() == 'DE') {
      return "Wenn die Person in einem Pflegeheim lebt,bitte die folgenden Daten eingeben";
    }
  }

  txtSeniorAddLocation() {
    if (getLanguage() == 'EN') {
      return "Add institute location";
    } else if (getLanguage() == 'DE') {
      return "Standort hinzufügen";
    }
  }

  // days of week shorted
  txtSeniorInstitute() {
    if (getLanguage() == 'EN') {
      return "Institute Name";
    } else if (getLanguage() == 'DE') {
      return "Name des Pflegeheims";
    }
  }

  txtSeniorInstituteHint() {
    if (getLanguage() == 'EN') {
      return "Enter institute name";
    } else if (getLanguage() == 'DE') {
      return "Name des Pflegeheims eingeben";
    }
  }

  txtSeniorCareAide() {
    if (getLanguage() == 'EN') {
      return "Care Aide’s Name";
    } else if (getLanguage() == 'DE') {
      return "Name des Pflegepersonals";
    }
  }

  txtSeniorCareAideHint() {
    if (getLanguage() == 'EN') {
      return "Enter care aide name";
    } else if (getLanguage() == 'DE') {
      return "Namen des Pflegepersonals eingeben";
    }
  }

  txtPetCard() {
    if (getLanguage() == 'EN') {
      return "Pet Profile";
    } else if (getLanguage() == 'DE') {
      return "Haustierprofil";
    }
  }

  txtPetCardHint() {
    if (getLanguage() == 'EN') {
      return "Please add Pet information";
    } else if (getLanguage() == 'DE') {
      return "Daten des Haustiers eingeben";
    }
  }

  txtPetBasicInfo() {
    if (getLanguage() == 'EN') {
      return "Pet Basic Details";
    } else if (getLanguage() == 'DE') {
      return "Haustier-Grunddaten";
    }
  }

  txtHintUserPet() {
    if (getLanguage() == 'EN') {
      return "Enter your username Pet";
    } else if (getLanguage() == 'DE') {
      return "Name eingeben";
    }
  }

  txtPetAgeHint() {
    if (getLanguage() == 'EN') {
      return "Enter your Pet age";
    } else if (getLanguage() == 'DE') {
      return "Alter eingeben";
    }
  }

  txtPetBodyInfo() {
    if (getLanguage() == 'EN') {
      return "Pet Body Shape Information";
    } else if (getLanguage() == 'DE') {
      return "Informationen zur Körperform.";
    }
  }

  txtPetHintCharacteristics() {
    if (getLanguage() == 'EN') {
      return "Enter Your Pet Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Merkmale eingeben";
    }
  }

  txtPetHintSpecialChar() {
    if (getLanguage() == 'EN') {
      return "Enter Your Pet Special Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Besondere Merkmale eingeben";
    }
  }

  txtPetHintBehavior() {
    if (getLanguage() == 'EN') {
      return "Enter Your Pet Behaviour";
    } else if (getLanguage() == 'DE') {
      return "Verhalten eingeben";
    }
  }

  txtPetHealthInfo() {
    if (getLanguage() == 'EN') {
      return "Pet Medical Profile";
    } else if (getLanguage() == 'DE') {
      return "Haustier-Medizinprofil";
    }
  }

  txtPetHintDiet() {
    if (getLanguage() == 'EN') {
      return "Enter your Pet diet";
    } else if (getLanguage() == 'DE') {
      return "Spezielle Ernährung eingeben.";
    }
  }

  txtPetHintAllergies() {
    if (getLanguage() == 'EN') {
      return "Enter your pet allergies";
    } else if (getLanguage() == 'DE') {
      return "Allergien eingeben";
    }
  }

  txtPetHitDiseases() {
    if (getLanguage() == 'EN') {
      return "Enter your pet diseases";
    } else if (getLanguage() == 'DE') {
      return "Krankheiten eingeben";
    }
  }

  txtPetHintMedicines() {
    if (getLanguage() == 'EN') {
      return "Enter your pet medication";
    } else if (getLanguage() == 'DE') {
      return "Medikamente eingeben";
    }
  }

  txtPetHintAdditionInfo() {
    if (getLanguage() == 'EN') {
      return "Enter your Pet addition information";
    } else if (getLanguage() == 'DE') {
      return "Zusätzliche Informationen eingeben";
    }
  }

  txtDisabledCard() {
    if (getLanguage() == 'EN') {
      return "Disabled Person Profile";
    } else if (getLanguage() == 'DE') {
      return "Profil der Person mit Behinderung";
    }
  }
  txtDisabledCardHint() {
    if (getLanguage() == 'EN') {
      return "Please add disabled person’s information.";
    } else if (getLanguage() == 'DE') {
      return "Daten der Person eingeben.";
    }
  }
  txtDisabledBasicInfo() {
    if (getLanguage() == 'EN') {
      return "Disabled person basic details: ";
    } else if (getLanguage() == 'DE') {
      return "der Person Basisdaten: ";
    }
  }

  txtHintUserDisabled() {
    if (getLanguage() == 'EN') {
      return "Enter the Disabled person's name";
    } else if (getLanguage() == 'DE') {
      return "Geben Sie den Namen der Person ein";
    }
  }

  txtDisabledAgeHint() {
    if (getLanguage() == 'EN') {
      return "Enter the Disabled person's age";
    } else if (getLanguage() == 'DE') {
      return "Geben Sie das Alter der Person ein";
    }
  }

  txtDisabledBodyInfo() {
    if (getLanguage() == 'EN') {
      return "Disable Person Body Shape Information: ";
    } else if (getLanguage() == 'DE') {
      return "Informationen zur Körperform: ";
    }
  }

  txtDisabledHintCharacteristics() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Merkmale eingeben";
    }
  }

  txtDisabledHintSpecialChar() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s Special Characteristics";
    } else if (getLanguage() == 'DE') {
      return "Besondere Merkmale eingeben";
    }
  }

  txtDisabledHintBehavior() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s Behaviour";
    } else if (getLanguage() == 'DE') {
      return "Verhalten eingeben";
    }
  }

  txtDisabledHealthInfo() {
    if (getLanguage() == 'EN') {
      return "Disabled Person Medical Profile:";
    } else if (getLanguage() == 'DE') {
      return "Medizinisches Profil einer Person mit Behinderung:";
    }
  }

  txtDisabledHintDiet() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s diet";
    } else if (getLanguage() == 'DE') {
      return "Spezielle Ernährung eingeben.";
    }
  }

  txtDisabledHintAllergies() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s allergies";
    } else if (getLanguage() == 'DE') {
      return "Allergien eingeben";
    }
  }

  txtDisabledHitDiseases() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s diseases";
    } else if (getLanguage() == 'DE') {
      return "Krankheiten eingeben";
    }
  }

  txtDisabledHintMedicines() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s medication";
    } else if (getLanguage() == 'DE') {
      return "Medikamente eingeben";
    }
  }

  txtDisabledHintAdditionInfo() {
    if (getLanguage() == 'EN') {
      return "Enter Disabled person’s addition information";
    } else if (getLanguage() == 'DE') {
      return "Zusätzliche Informationen hinzufügen.";
    }
  }
  txtDisabledHome() {
    if (getLanguage() == 'EN') {
      return "Disabled Person’s Home";
    } else if (getLanguage() == 'DE') {
      return "Behindertenheim";
    }
  }


  txtDisabledHomeInfo() {
    if (getLanguage() == 'EN') {
      return "If Disabled Person’s lives in a special institute, Please enter the following data:";
    } else if (getLanguage() == 'DE') {
      return "Wenn die Person in einem Pflegeheim lebt, bitte die folgenden Daten eingeben:";
    }
  }

  txtItemCard() {
    if (getLanguage() == 'EN') {
      return "Item Profile";
    } else if (getLanguage() == 'DE') {
      return "Artikelprofil";
    }
  }

  txtItemCardHint() {
    if (getLanguage() == 'EN') {
      return "Please add your item information";
    } else if (getLanguage() == 'DE') {
      return "Erstellen Sie ein Artikelprofil";
    }
  }
  txtItemBasicInfo() {
    if (getLanguage() == 'EN') {
      return "Item Basic Details";
    } else if (getLanguage() == 'DE') {
      return "Grundlegende Artikelangaben";
    }
  }
  txtHintUserItem() {
    if (getLanguage() == 'EN') {
      return "Enter your name Item";
    } else if (getLanguage() == 'DE') {
      return "Artikeltyp eingeben";
    }
  }

  txtItemHintAdditionInfo() {
    if (getLanguage() == 'EN') {
      return "Enter Item addition information";
    } else if (getLanguage() == 'DE') {
      return "Zusätzliche Informationen";
    }
  }

  txtCreateData() {
    if (getLanguage() == 'EN') {
      return "Creation Date: ";
    } else if (getLanguage() == 'DE') {
      return "Erstellungsdatum: ";
    }
  }

}
