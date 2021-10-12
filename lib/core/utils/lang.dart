import 'package:get/get.dart';

class Lang extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //'hi_IN': {'hello': 'नमस्ते'},
        //'fr_FR': {'hello': 'Bonjour'},
        'en_US': {
          //onBoarding
          'onBoarding_title1': 'Choose services you want from verified profits',
          'onBoarding_title2':
              'Get posts daily from businesses you follow to stay updated.',
          'onBoarding_title3':
              'Select Categories of businesses you like to get personalized services',
          //buttons
          'next': 'Next', 'skip': 'Skip',
          'user': 'User',
          'service_provider': 'Service Provider',
          //which services you choose
          'how_would..': 'How would you like to\nJoin?',
          //login
          'user_login': 'User Login',
          'service_provider_login': 'Service Provider Login',
          'get_started': 'Get Started',
          'enter_your..': 'Enter your account details for getting started.',
          'email_address': 'Email Address',
          'email': 'Email',
          'password': 'Password',
          'show': 'Show',
          'hide': 'Hide',
          'forgot_your_password': 'Forgot your password?',
          'check_your_email': 'Check your email',
          'login': 'Login',
          'create_an_account': 'Create an account',
          'continue_as_guest': 'Continue as guest',
          'or': 'or',
          'continue_with..':
              'Continue with social login for more\npersonalized experience.',
          'invalid_email': 'Invalid Email',
          'invalid_password': 'Invalid Password',
          'enter_email': 'Please Enter Email',
          'enter_password': 'Please Enter Password',
          'check_your_connection': 'Check your connection',
          //forgot password
          'forgot_password': 'Forgot Password',
          'enter_your_email..': "Enter your email id to find account",
          'e_mail': 'E-Mail',
          'email_example': 'example@mail.com',
          'password_example': 'XXXXXXXX',
          'submit': 'Submit',
          'save': 'Save',
          'a_link_to..':
              'A link to reset your password has been sent to your registered email account.',
          //register
          'name': 'Name',
          'confirm_password': 'Confirm Password',
          'already_have': 'Already have an account! ',
          'signup': 'Signup',
          //email verify
          'email_verify..':
              'An Email with Verification Link is Sent to your email account. Please verify to Login.',
          'ok': 'Ok',
          //main screen
          'feeds': 'Feeds',
          'messages': 'Messages',
          'notifications': 'Notifications',
          'profile': 'Profile',
          //home screen
          'change': 'Change',
          'business_categories': 'Business Categories',
          'view_all': 'View All',
          'see_all': 'See All',
          'see_less': 'See Less',
          'like_error':
              "Hey, You can't post & comment on news feeds until your profile is verified",
          'go_to_profile': "Go to Profile",
          'view_profile': 'View Profile',
          //create Post
          'create_post': 'Create Post',
          'take_a_photo': 'Take a photo',
          'take_a_video': 'Take a video',
          'what_do_you..': 'What do you want to talk about?',
          'post': 'Post',
          'post_msg':
              'Hey, your post has been successfully posted on news feeds.',
          'go_to_home': 'Go To Home',
          'Leave your comments here...': 'Leave your comments here...',
          //business categories
          'apply': 'Apply',
          //post details
          'post_details': 'Post Details',
          'comments': 'Comments',
          'view_all_comments': 'View All Comments',
          'no_comments': ' No Comments',
          'textfieldmsg1': 'Leave your comments here...',
          //business profile
          'business_profile': 'Business Profile',
          'basic_information': 'Basic Information',
          'phone': 'Phone',
          'follow': 'Follow',
          'contact': 'Contact',
          'message': 'Message',
          'description': 'Description',
          'website_links': 'Website Links',
          'location': 'Location',
          'availability': 'Availability',
          'open': 'Open',
          'closed': 'Closed',
          'working_hours': 'Working Hours',
          'working_days': 'Working Days',
          'services_offered': 'Services Offered',
          'customer_reviews': 'Customer Reviews',
          'warning': 'Warning',
          //edit profile business
          'edit_business_profile': 'Edit Business Profile',
          'business_details': 'Business Details',
          'business_name': 'Business Name',
          'business_category': 'Business Category',
          'phone_number': 'Phone Number',
          'add': 'Add',
          'enter_website_url': 'Enter Website Url',
          'cancel': 'Cancel',
          //set availability
          'set_availability': 'Set Availability',
          'select_working_days': 'Select Working Days',
          'select_working_hours': 'Select Working Hours',
          'opening_hour': 'Opening Hour',
          'closing_hour': 'Closing Hour',
          'starts': 'Start',
          'end': 'End',
          //add services offered
          'add_services_offered': 'Add Services Offered',
          'name_of_service': 'Name of service',
          'add_more_service': 'Add More Services',
          'dialogue_msg':
              'Thank you for registering with business app. once admin will verify your business profile. you will be notified.',

          //messsages
          'textfieldmsg2': 'Type here..',
          //customer review
          'give_feedback': 'Give Feedback',
          //give feedback
          'how_was..': 'How was your experience with\nbusiness name',
          'your_feedback..': 'Your feedback matters to us.',
          'write_your..': 'Write your review',
          'upload_photo': 'Upload photo',
          'click_here': 'Click here to upload',
          'submitting_review': 'Thanks you for submitting your reviews.',
          //profile
          'user_name': 'User Name',
          'about_business': 'About Business',
          'settings': 'Settings',
          //edit profile
          'edit_profile': 'Edit Profile',
          'change_image': 'Change Image',

          //settings
          'about_us': 'About Us',
          'terms': 'Terms & Conditions',
          'contact_admin': 'Contact Admin',
          'faqs': 'FAQs',
          'logOut': 'Logout',
          'terms_and_conditions': 'Terms and Conditions',
          //About Us
          'aboutusdes':
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
          //Terms and Conditions
          'termsandconditiondes':
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,",
          //Contact Admin
          'how_can_we_help': 'How can we help?',
          'dialog_msg':
              'Thanks you for submitting your request. we will surely help you.',
          //validations
          'enter_mobile_number': 'Please enter mobile number',
          'enter_business_name': 'Please enter business name',
          'enter_category': 'Please select category',
          'enter_description': 'Please enter description',
          'enter_location': 'Please enter location',
          'enter_websites': 'Please enter websites',
          'select_image': 'Please select image',
          'password_not_matched': 'Password not matched',
          'please_enter_name': 'Please enter name',
          'please_enter_email': 'Please enter email',
          'please_enter_password': 'Please enter password',
          'please_enter_valid_email': 'Please enter valid email',

          //toasts
          'please_select_working_days': 'Please select working days',
          'please_select_working_hours': 'Please select working hours',
          'no_post_found': 'No post found',
          'please_enter_service': 'Please Enter Service',
        },
      };
}
