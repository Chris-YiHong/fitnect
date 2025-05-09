///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsRatePopupEn rate_popup = TranslationsRatePopupEn.internal(_root);
	late final TranslationsPremiumEn premium = TranslationsPremiumEn.internal(_root);
	late final TranslationsPaywallWithSwitchEn paywallWithSwitch = TranslationsPaywallWithSwitchEn.internal(_root);
	late final TranslationsRequestNotificationPermissionEn request_notification_permission = TranslationsRequestNotificationPermissionEn.internal(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn.internal(_root);
	late final TranslationsFeatureRequestsEn feature_requests = TranslationsFeatureRequestsEn.internal(_root);
	late final TranslationsSignupOnboardingEn signup_onboarding = TranslationsSignupOnboardingEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'FitNect example';
}

// Path: rate_popup
class TranslationsRatePopupEn {
	TranslationsRatePopupEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Would you have 15s to rate us?';
	String get description => 'It\'s fast and very helpful! Thanks a lot!';
	String get cancel_button => 'Maybe later';
	String get rate_button => 'Yes, with pleasure!';
}

// Path: premium
class TranslationsPremiumEn {
	TranslationsPremiumEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title_1 => 'Unlock full access';
	String get description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
	String get feature_1 => 'Lorem ipsum dolor sit ame lorem';
	String get feature_2 => 'Lorem ipsum dolor sit ame lorem';
	String get feature_3 => 'Lorem ipsum dolor sit ame lorem';
	String get duration_weekly => 'Weak';
	String get duration_annual => 'Year';
	String get duration_annual_description => 'Save 50%';
	String get duration_monthly => 'Month';
	String get duration_monthly_description => 'Cancel anytime';
	String get duration_lifetime => 'Lifetime';
	String get duration_lifetime_description => 'One time payment';
	String get restore_action => 'Restore my subscription';
	String get payment_cancel_reassurance => 'Easy 1-click cancel, always';
	String get payment_action => 'Start free trial';
	String payment_action_trial({required Object money}) => '7-day free trial, then ${money}';
}

// Path: paywallWithSwitch
class TranslationsPaywallWithSwitchEn {
	TranslationsPaywallWithSwitchEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPaywallWithSwitchWithTrialEn withTrial = TranslationsPaywallWithSwitchWithTrialEn.internal(_root);
	late final TranslationsPaywallWithSwitchNoTrialEn noTrial = TranslationsPaywallWithSwitchNoTrialEn.internal(_root);
	List<String> get features => [
		'Lorem feature 1',
		'Lorem feature 2',
		'Lorem feature 3',
		'Cancel anytime',
	];
}

// Path: request_notification_permission
class TranslationsRequestNotificationPermissionEn {
	TranslationsRequestNotificationPermissionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Don\'t miss anything';
	String get description => 'Allow us to send you notifications to stay up to date with the latest news...';
	String get continue_button => 'Allow notifications';
	String get skip_button => 'Maybe later';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsOnboardingFeature1En feature_1 = TranslationsOnboardingFeature1En.internal(_root);
	late final TranslationsOnboardingFeature2En feature_2 = TranslationsOnboardingFeature2En.internal(_root);
	late final TranslationsOnboardingFeature3En feature_3 = TranslationsOnboardingFeature3En.internal(_root);
	late final TranslationsOnboardingAgeQuestionEn ageQuestion = TranslationsOnboardingAgeQuestionEn.internal(_root);
	late final TranslationsOnboardingGenderQuestionEn genderQuestion = TranslationsOnboardingGenderQuestionEn.internal(_root);
	late final TranslationsOnboardingNotificationsEn notifications = TranslationsOnboardingNotificationsEn.internal(_root);
	late final TranslationsOnboardingLoadingEn loading = TranslationsOnboardingLoadingEn.internal(_root);
}

// Path: feature_requests
class TranslationsFeatureRequestsEn {
	TranslationsFeatureRequestsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Your opinion matters!';
	String get description => 'Vote or suggest new features.\nWe listen everyone of you to create the best possible app.';
	late final TranslationsFeatureRequestsVoteSuccessEn vote_success = TranslationsFeatureRequestsVoteSuccessEn.internal(_root);
	late final TranslationsFeatureRequestsVoteErrorEn vote_error = TranslationsFeatureRequestsVoteErrorEn.internal(_root);
	late final TranslationsFeatureRequestsAddFeatureEn add_feature = TranslationsFeatureRequestsAddFeatureEn.internal(_root);
}

// Path: signup_onboarding
class TranslationsSignupOnboardingEn {
	TranslationsSignupOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSignupOnboardingHeaderEn header = TranslationsSignupOnboardingHeaderEn.internal(_root);
	late final TranslationsSignupOnboardingNavigationEn navigation = TranslationsSignupOnboardingNavigationEn.internal(_root);
	String unknown_step({required Object step}) => 'Unknown step: ${step}';
	late final TranslationsSignupOnboardingNameEn name = TranslationsSignupOnboardingNameEn.internal(_root);
	late final TranslationsSignupOnboardingGenderEn gender = TranslationsSignupOnboardingGenderEn.internal(_root);
	late final TranslationsSignupOnboardingBirthdayEn birthday = TranslationsSignupOnboardingBirthdayEn.internal(_root);
	late final TranslationsSignupOnboardingHeightEn height = TranslationsSignupOnboardingHeightEn.internal(_root);
	late final TranslationsSignupOnboardingWeightEn weight = TranslationsSignupOnboardingWeightEn.internal(_root);
	late final TranslationsSignupOnboardingFitnessGoalEn fitness_goal = TranslationsSignupOnboardingFitnessGoalEn.internal(_root);
	late final TranslationsSignupOnboardingActivityEn activity = TranslationsSignupOnboardingActivityEn.internal(_root);
	late final TranslationsSignupOnboardingDietEn diet = TranslationsSignupOnboardingDietEn.internal(_root);
	late final TranslationsSignupOnboardingInjuriesHistoryEn injuries_history = TranslationsSignupOnboardingInjuriesHistoryEn.internal(_root);
	late final TranslationsSignupOnboardingHealthConditionEn health_condition = TranslationsSignupOnboardingHealthConditionEn.internal(_root);
	late final TranslationsSignupOnboardingCompletedEn completed = TranslationsSignupOnboardingCompletedEn.internal(_root);
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAuthSigninHeaderEn signin_header = TranslationsAuthSigninHeaderEn.internal(_root);
}

// Path: paywallWithSwitch.withTrial
class TranslationsPaywallWithSwitchWithTrialEn {
	TranslationsPaywallWithSwitchWithTrialEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object days}) => 'Try Free for ${days} days';
	String get btnAction => 'Try for free';
	String details({required Object days, required Object price}) => '${days} days free, then ${price}';
	String trial_switch_title({required Object days}) => '${days}-day free trial';
}

// Path: paywallWithSwitch.noTrial
class TranslationsPaywallWithSwitchNoTrialEn {
	TranslationsPaywallWithSwitchNoTrialEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Enjoy Your Premium Experience';
	String get btnAction => 'Continue';
	String get trial_switch_title => 'Not sure yet?';
	String get trial_switch_subtitle => 'Enable free trial';
}

// Path: onboarding.feature_1
class TranslationsOnboardingFeature1En {
	TranslationsOnboardingFeature1En.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Subscriptions module';
	String get description => 'Manage subscriptions with premade paywalls';
	String get action => 'Continue';
}

// Path: onboarding.feature_2
class TranslationsOnboardingFeature2En {
	TranslationsOnboardingFeature2En.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Authentication module';
	String get description => 'Manage authentication with premade screens for (login, register, forgot password, etc.)';
	String get action => 'Continue';
}

// Path: onboarding.feature_3
class TranslationsOnboardingFeature3En {
	TranslationsOnboardingFeature3En.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Notifications module';
	String get description => 'Receive push notifications, show in-app notifications, manage permissions, notifications list with status...';
	String get action => 'Continue';
}

// Path: onboarding.ageQuestion
class TranslationsOnboardingAgeQuestionEn {
	TranslationsOnboardingAgeQuestionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What is your age?';
	String get description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
	Map<String, String> get options => {
		'age18_30': '[18 - 30] years old',
		'age31_40': '[31 - 40] years old',
		'age41_50': '[41 - 50] years old',
		'age51_60': '50 years and above',
		'none': 'I prefer not to answer',
	};
	String get action => 'Continue';
}

// Path: onboarding.genderQuestion
class TranslationsOnboardingGenderQuestionEn {
	TranslationsOnboardingGenderQuestionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What is your gender?';
	String get description => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
	Map<String, String> get options => {
		'male': 'Male',
		'female': 'Female',
		'none': 'I prefer not to answer',
	};
	String get action => 'Continue';
}

// Path: onboarding.notifications
class TranslationsOnboardingNotificationsEn {
	TranslationsOnboardingNotificationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Allow notifications';
	String get description => 'We will only send you important notifications';
	String get continue_button => 'Allow notifications';
	String get skip_button => 'Maybe later';
}

// Path: onboarding.loading
class TranslationsOnboardingLoadingEn {
	TranslationsOnboardingLoadingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Creating your profile';
	String get subtitle => 'Wait a few seconds';
}

// Path: feature_requests.vote_success
class TranslationsFeatureRequestsVoteSuccessEn {
	TranslationsFeatureRequestsVoteSuccessEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Thank you!';
	String get description => 'Your vote has been taken into account';
}

// Path: feature_requests.vote_error
class TranslationsFeatureRequestsVoteErrorEn {
	TranslationsFeatureRequestsVoteErrorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Error';
	String get description => 'You already voted for a feature';
}

// Path: feature_requests.add_feature
class TranslationsFeatureRequestsAddFeatureEn {
	TranslationsFeatureRequestsAddFeatureEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Suggest a feature';
	String get description => 'What feature would you like to see in the app?';
	String get save_button => 'Send';
	String get title_label => 'Feature title';
	String get title_hint => 'Enter a short descriptive title';
	String get description_label => 'Description';
	String get description_hint => 'Describe the feature or the improvement you would like to see in the app';
	late final TranslationsFeatureRequestsAddFeatureToastSuccessEn toast_success = TranslationsFeatureRequestsAddFeatureToastSuccessEn.internal(_root);
}

// Path: signup_onboarding.header
class TranslationsSignupOnboardingHeaderEn {
	TranslationsSignupOnboardingHeaderEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Welcome to FitNect';
	String get subtitle => 'Before we begin, let\'s get to know you better!';
}

// Path: signup_onboarding.navigation
class TranslationsSignupOnboardingNavigationEn {
	TranslationsSignupOnboardingNavigationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get next => 'Next';
	String get get_started => 'Get Started';
}

// Path: signup_onboarding.name
class TranslationsSignupOnboardingNameEn {
	TranslationsSignupOnboardingNameEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What should we call you?';
	String get placeholder => 'Enter a nickname';
}

// Path: signup_onboarding.gender
class TranslationsSignupOnboardingGenderEn {
	TranslationsSignupOnboardingGenderEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What\'s your Gender?';
	String get male => 'Male';
	String get female => 'Female';
	String get other => 'Other';
	String get prefer_not_to_say => 'Prefer not to say';
}

// Path: signup_onboarding.birthday
class TranslationsSignupOnboardingBirthdayEn {
	TranslationsSignupOnboardingBirthdayEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'When were you born?';
	String get subtitle => 'This helps us customize your fitness plan';
}

// Path: signup_onboarding.height
class TranslationsSignupOnboardingHeightEn {
	TranslationsSignupOnboardingHeightEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What\'s your height?';
	String get subtitle => 'We\'ll use this to calculate your BMI';
	String get cm => 'cm';
}

// Path: signup_onboarding.weight
class TranslationsSignupOnboardingWeightEn {
	TranslationsSignupOnboardingWeightEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What\'s your weight?';
	String get subtitle => 'This helps us track your progress';
	String get kg => 'kg';
}

// Path: signup_onboarding.fitness_goal
class TranslationsSignupOnboardingFitnessGoalEn {
	TranslationsSignupOnboardingFitnessGoalEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What are your fitness goals?';
	String get subtitle => 'Select all that apply';
	String get lose_weight => 'Lose Weight';
	String get gain_muscle => 'Gain Muscle';
	String get improve_fitness => 'Improve Fitness';
	String get increase_endurance => 'Increase Endurance';
	String get improve_flexibility => 'Improve Flexibility';
	String get other => 'Other';
}

// Path: signup_onboarding.activity
class TranslationsSignupOnboardingActivityEn {
	TranslationsSignupOnboardingActivityEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What\'s your activity level?';
	String get subtitle => 'This helps us determine your daily calorie needs';
	String get sedentary => 'Sedentary';
	String get sedentary_description => 'Little to no exercise';
	String get light => 'Lightly Active';
	String get light_description => 'Light exercise 1-3 days/week';
	String get moderate => 'Moderately Active';
	String get moderate_description => 'Moderate exercise 3-5 days/week';
	String get active => 'Active';
	String get active_description => 'Hard exercise 6-7 days/week';
	String get very_active => 'Very Active';
	String get very_active_description => 'Hard daily exercise & physical job';
}

// Path: signup_onboarding.diet
class TranslationsSignupOnboardingDietEn {
	TranslationsSignupOnboardingDietEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'What\'s your diet like?';
	String get subtitle => 'Tell us about your eating habits';
	String get placeholder => 'Describe your typical diet...';
	String get suggestions_title => 'Suggestions:';
	String get suggestion_1 => 'Vegetarian';
	String get suggestion_2 => 'Vegan';
	String get suggestion_3 => 'Keto';
	String get suggestion_4 => 'Paleo';
	String get suggestion_5 => 'Balanced';
}

// Path: signup_onboarding.injuries_history
class TranslationsSignupOnboardingInjuriesHistoryEn {
	TranslationsSignupOnboardingInjuriesHistoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Do you have any injuries?';
	String get subtitle => 'This helps us customize your workouts';
	String get no_injuries => 'No injuries to report';
	String get add_injury => 'Add an injury';
	String get injury_name => 'Injury name';
	String get injury_description => 'Description';
	String get injury_date => 'Date:';
	String get add_button => 'Add Injury';
}

// Path: signup_onboarding.health_condition
class TranslationsSignupOnboardingHealthConditionEn {
	TranslationsSignupOnboardingHealthConditionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Do you have any health conditions?';
	String get subtitle => 'This helps us customize your workouts safely';
	String get no_conditions => 'No health conditions to report';
	String get add_condition => 'Add a health condition';
	String get condition_name => 'Condition name';
	String get condition_description => 'Description (optional)';
	String get add_button => 'Add Condition';
}

// Path: signup_onboarding.completed
class TranslationsSignupOnboardingCompletedEn {
	TranslationsSignupOnboardingCompletedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get processing => 'Processing...';
	String get success_title => 'You\'re all set!';
	String get success_subtitle => 'Thank you for providing your information. We\'re excited to start your fitness journey!';
	String get error_title => 'Something went wrong';
	String get error_subtitle => 'We couldn\'t complete your registration. Please try again.';
	String get preparing => 'Preparing your profile';
	String get preparing_subtitle => 'Just a moment while we prepare everything...';
	String get profile_summary => 'Your Profile Summary';
	String get name_label => 'Name';
	String get gender_label => 'Gender';
	String get age_label => 'Age';
	String get height_label => 'Height';
	String get weight_label => 'Weight';
	String get goals_label => 'Goals';
	String get activity_label => 'Activity';
	String get retry_button => 'Retry';
}

// Path: auth.signin_header
class TranslationsAuthSigninHeaderEn {
	TranslationsAuthSigninHeaderEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get welcome_back => 'Welcome back!';
	String get sign_in_to => 'Sign in to FitNect';
}

// Path: feature_requests.add_feature.toast_success
class TranslationsFeatureRequestsAddFeatureToastSuccessEn {
	TranslationsFeatureRequestsAddFeatureToastSuccessEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Thank you!';
	String get description => 'We will review your suggestion';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'home.title': return 'FitNect example';
			case 'rate_popup.title': return 'Would you have 15s to rate us?';
			case 'rate_popup.description': return 'It\'s fast and very helpful! Thanks a lot!';
			case 'rate_popup.cancel_button': return 'Maybe later';
			case 'rate_popup.rate_button': return 'Yes, with pleasure!';
			case 'premium.title_1': return 'Unlock full access';
			case 'premium.description': return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			case 'premium.feature_1': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.feature_2': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.feature_3': return 'Lorem ipsum dolor sit ame lorem';
			case 'premium.duration_weekly': return 'Weak';
			case 'premium.duration_annual': return 'Year';
			case 'premium.duration_annual_description': return 'Save 50%';
			case 'premium.duration_monthly': return 'Month';
			case 'premium.duration_monthly_description': return 'Cancel anytime';
			case 'premium.duration_lifetime': return 'Lifetime';
			case 'premium.duration_lifetime_description': return 'One time payment';
			case 'premium.restore_action': return 'Restore my subscription';
			case 'premium.payment_cancel_reassurance': return 'Easy 1-click cancel, always';
			case 'premium.payment_action': return 'Start free trial';
			case 'premium.payment_action_trial': return ({required Object money}) => '7-day free trial, then ${money}';
			case 'paywallWithSwitch.withTrial.title': return ({required Object days}) => 'Try Free for ${days} days';
			case 'paywallWithSwitch.withTrial.btnAction': return 'Try for free';
			case 'paywallWithSwitch.withTrial.details': return ({required Object days, required Object price}) => '${days} days free, then ${price}';
			case 'paywallWithSwitch.withTrial.trial_switch_title': return ({required Object days}) => '${days}-day free trial';
			case 'paywallWithSwitch.noTrial.title': return 'Enjoy Your Premium Experience';
			case 'paywallWithSwitch.noTrial.btnAction': return 'Continue';
			case 'paywallWithSwitch.noTrial.trial_switch_title': return 'Not sure yet?';
			case 'paywallWithSwitch.noTrial.trial_switch_subtitle': return 'Enable free trial';
			case 'paywallWithSwitch.features.0': return 'Lorem feature 1';
			case 'paywallWithSwitch.features.1': return 'Lorem feature 2';
			case 'paywallWithSwitch.features.2': return 'Lorem feature 3';
			case 'paywallWithSwitch.features.3': return 'Cancel anytime';
			case 'request_notification_permission.title': return 'Don\'t miss anything';
			case 'request_notification_permission.description': return 'Allow us to send you notifications to stay up to date with the latest news...';
			case 'request_notification_permission.continue_button': return 'Allow notifications';
			case 'request_notification_permission.skip_button': return 'Maybe later';
			case 'onboarding.feature_1.title': return 'Subscriptions module';
			case 'onboarding.feature_1.description': return 'Manage subscriptions with premade paywalls';
			case 'onboarding.feature_1.action': return 'Continue';
			case 'onboarding.feature_2.title': return 'Authentication module';
			case 'onboarding.feature_2.description': return 'Manage authentication with premade screens for (login, register, forgot password, etc.)';
			case 'onboarding.feature_2.action': return 'Continue';
			case 'onboarding.feature_3.title': return 'Notifications module';
			case 'onboarding.feature_3.description': return 'Receive push notifications, show in-app notifications, manage permissions, notifications list with status...';
			case 'onboarding.feature_3.action': return 'Continue';
			case 'onboarding.ageQuestion.title': return 'What is your age?';
			case 'onboarding.ageQuestion.description': return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			case 'onboarding.ageQuestion.options.age18_30': return '[18 - 30] years old';
			case 'onboarding.ageQuestion.options.age31_40': return '[31 - 40] years old';
			case 'onboarding.ageQuestion.options.age41_50': return '[41 - 50] years old';
			case 'onboarding.ageQuestion.options.age51_60': return '50 years and above';
			case 'onboarding.ageQuestion.options.none': return 'I prefer not to answer';
			case 'onboarding.ageQuestion.action': return 'Continue';
			case 'onboarding.genderQuestion.title': return 'What is your gender?';
			case 'onboarding.genderQuestion.description': return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
			case 'onboarding.genderQuestion.options.male': return 'Male';
			case 'onboarding.genderQuestion.options.female': return 'Female';
			case 'onboarding.genderQuestion.options.none': return 'I prefer not to answer';
			case 'onboarding.genderQuestion.action': return 'Continue';
			case 'onboarding.notifications.title': return 'Allow notifications';
			case 'onboarding.notifications.description': return 'We will only send you important notifications';
			case 'onboarding.notifications.continue_button': return 'Allow notifications';
			case 'onboarding.notifications.skip_button': return 'Maybe later';
			case 'onboarding.loading.title': return 'Creating your profile';
			case 'onboarding.loading.subtitle': return 'Wait a few seconds';
			case 'feature_requests.title': return 'Your opinion matters!';
			case 'feature_requests.description': return 'Vote or suggest new features.\nWe listen everyone of you to create the best possible app.';
			case 'feature_requests.vote_success.title': return 'Thank you!';
			case 'feature_requests.vote_success.description': return 'Your vote has been taken into account';
			case 'feature_requests.vote_error.title': return 'Error';
			case 'feature_requests.vote_error.description': return 'You already voted for a feature';
			case 'feature_requests.add_feature.title': return 'Suggest a feature';
			case 'feature_requests.add_feature.description': return 'What feature would you like to see in the app?';
			case 'feature_requests.add_feature.save_button': return 'Send';
			case 'feature_requests.add_feature.title_label': return 'Feature title';
			case 'feature_requests.add_feature.title_hint': return 'Enter a short descriptive title';
			case 'feature_requests.add_feature.description_label': return 'Description';
			case 'feature_requests.add_feature.description_hint': return 'Describe the feature or the improvement you would like to see in the app';
			case 'feature_requests.add_feature.toast_success.title': return 'Thank you!';
			case 'feature_requests.add_feature.toast_success.description': return 'We will review your suggestion';
			case 'signup_onboarding.header.title': return 'Welcome to FitNect';
			case 'signup_onboarding.header.subtitle': return 'Before we begin, let\'s get to know you better!';
			case 'signup_onboarding.navigation.next': return 'Next';
			case 'signup_onboarding.navigation.get_started': return 'Get Started';
			case 'signup_onboarding.unknown_step': return ({required Object step}) => 'Unknown step: ${step}';
			case 'signup_onboarding.name.title': return 'What should we call you?';
			case 'signup_onboarding.name.placeholder': return 'Enter a nickname';
			case 'signup_onboarding.gender.title': return 'What\'s your Gender?';
			case 'signup_onboarding.gender.male': return 'Male';
			case 'signup_onboarding.gender.female': return 'Female';
			case 'signup_onboarding.gender.other': return 'Other';
			case 'signup_onboarding.gender.prefer_not_to_say': return 'Prefer not to say';
			case 'signup_onboarding.birthday.title': return 'When were you born?';
			case 'signup_onboarding.birthday.subtitle': return 'This helps us customize your fitness plan';
			case 'signup_onboarding.height.title': return 'What\'s your height?';
			case 'signup_onboarding.height.subtitle': return 'We\'ll use this to calculate your BMI';
			case 'signup_onboarding.height.cm': return 'cm';
			case 'signup_onboarding.weight.title': return 'What\'s your weight?';
			case 'signup_onboarding.weight.subtitle': return 'This helps us track your progress';
			case 'signup_onboarding.weight.kg': return 'kg';
			case 'signup_onboarding.fitness_goal.title': return 'What are your fitness goals?';
			case 'signup_onboarding.fitness_goal.subtitle': return 'Select all that apply';
			case 'signup_onboarding.fitness_goal.lose_weight': return 'Lose Weight';
			case 'signup_onboarding.fitness_goal.gain_muscle': return 'Gain Muscle';
			case 'signup_onboarding.fitness_goal.improve_fitness': return 'Improve Fitness';
			case 'signup_onboarding.fitness_goal.increase_endurance': return 'Increase Endurance';
			case 'signup_onboarding.fitness_goal.improve_flexibility': return 'Improve Flexibility';
			case 'signup_onboarding.fitness_goal.other': return 'Other';
			case 'signup_onboarding.activity.title': return 'What\'s your activity level?';
			case 'signup_onboarding.activity.subtitle': return 'This helps us determine your daily calorie needs';
			case 'signup_onboarding.activity.sedentary': return 'Sedentary';
			case 'signup_onboarding.activity.sedentary_description': return 'Little to no exercise';
			case 'signup_onboarding.activity.light': return 'Lightly Active';
			case 'signup_onboarding.activity.light_description': return 'Light exercise 1-3 days/week';
			case 'signup_onboarding.activity.moderate': return 'Moderately Active';
			case 'signup_onboarding.activity.moderate_description': return 'Moderate exercise 3-5 days/week';
			case 'signup_onboarding.activity.active': return 'Active';
			case 'signup_onboarding.activity.active_description': return 'Hard exercise 6-7 days/week';
			case 'signup_onboarding.activity.very_active': return 'Very Active';
			case 'signup_onboarding.activity.very_active_description': return 'Hard daily exercise & physical job';
			case 'signup_onboarding.diet.title': return 'What\'s your diet like?';
			case 'signup_onboarding.diet.subtitle': return 'Tell us about your eating habits';
			case 'signup_onboarding.diet.placeholder': return 'Describe your typical diet...';
			case 'signup_onboarding.diet.suggestions_title': return 'Suggestions:';
			case 'signup_onboarding.diet.suggestion_1': return 'Vegetarian';
			case 'signup_onboarding.diet.suggestion_2': return 'Vegan';
			case 'signup_onboarding.diet.suggestion_3': return 'Keto';
			case 'signup_onboarding.diet.suggestion_4': return 'Paleo';
			case 'signup_onboarding.diet.suggestion_5': return 'Balanced';
			case 'signup_onboarding.injuries_history.title': return 'Do you have any injuries?';
			case 'signup_onboarding.injuries_history.subtitle': return 'This helps us customize your workouts';
			case 'signup_onboarding.injuries_history.no_injuries': return 'No injuries to report';
			case 'signup_onboarding.injuries_history.add_injury': return 'Add an injury';
			case 'signup_onboarding.injuries_history.injury_name': return 'Injury name';
			case 'signup_onboarding.injuries_history.injury_description': return 'Description';
			case 'signup_onboarding.injuries_history.injury_date': return 'Date:';
			case 'signup_onboarding.injuries_history.add_button': return 'Add Injury';
			case 'signup_onboarding.health_condition.title': return 'Do you have any health conditions?';
			case 'signup_onboarding.health_condition.subtitle': return 'This helps us customize your workouts safely';
			case 'signup_onboarding.health_condition.no_conditions': return 'No health conditions to report';
			case 'signup_onboarding.health_condition.add_condition': return 'Add a health condition';
			case 'signup_onboarding.health_condition.condition_name': return 'Condition name';
			case 'signup_onboarding.health_condition.condition_description': return 'Description (optional)';
			case 'signup_onboarding.health_condition.add_button': return 'Add Condition';
			case 'signup_onboarding.completed.processing': return 'Processing...';
			case 'signup_onboarding.completed.success_title': return 'You\'re all set!';
			case 'signup_onboarding.completed.success_subtitle': return 'Thank you for providing your information. We\'re excited to start your fitness journey!';
			case 'signup_onboarding.completed.error_title': return 'Something went wrong';
			case 'signup_onboarding.completed.error_subtitle': return 'We couldn\'t complete your registration. Please try again.';
			case 'signup_onboarding.completed.preparing': return 'Preparing your profile';
			case 'signup_onboarding.completed.preparing_subtitle': return 'Just a moment while we prepare everything...';
			case 'signup_onboarding.completed.profile_summary': return 'Your Profile Summary';
			case 'signup_onboarding.completed.name_label': return 'Name';
			case 'signup_onboarding.completed.gender_label': return 'Gender';
			case 'signup_onboarding.completed.age_label': return 'Age';
			case 'signup_onboarding.completed.height_label': return 'Height';
			case 'signup_onboarding.completed.weight_label': return 'Weight';
			case 'signup_onboarding.completed.goals_label': return 'Goals';
			case 'signup_onboarding.completed.activity_label': return 'Activity';
			case 'signup_onboarding.completed.retry_button': return 'Retry';
			case 'auth.signin_header.welcome_back': return 'Welcome back!';
			case 'auth.signin_header.sign_in_to': return 'Sign in to FitNect';
			default: return null;
		}
	}
}

