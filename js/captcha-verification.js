/**
 * Pricol Logistics - CAPTCHA Verification Manager
 * Generates dynamic 6-character Security CAPTCHA codes for Enquire & Careers forms
 * Validates user input before form submission.
 */
(function () {
	'use strict';

	const captchas = {
		enquire: '',
		careers: ''
	};

	function generateCode(length) {
		const chars = '23456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnpqrstuvwxyz';
		let code = '';
		for (let i = 0; i < (length || 6); i++) {
			code += chars.charAt(Math.floor(Math.random() * chars.length));
		}
		return code;
	}

	window.refreshCaptcha = function (type) {
		const code = generateCode(6);
		captchas[type] = code;

		const canvas = document.getElementById(type + '-captcha-canvas');
		const input = document.getElementById(type + '-captcha-input');
		const error = document.getElementById(type + '-captcha-error');

		if (canvas) {
			canvas.innerText = code;
		}
		if (input) {
			input.value = '';
			input.classList.remove('captcha-error-border', 'captcha-success-border');
		}
		if (error) {
			error.style.display = 'none';
		}
	};

	function setupFormValidation(formSelector, type) {
		const form = typeof formSelector === 'string' ? (document.getElementById(formSelector) || document.querySelector(formSelector)) : formSelector;
		if (!form) return;

		form.addEventListener('submit', function (e) {
			const input = document.getElementById(type + '-captcha-input');
			const error = document.getElementById(type + '-captcha-error');
			const userVal = input ? input.value.trim() : '';

			if (!userVal || userVal.toUpperCase() !== captchas[type].toUpperCase()) {
				e.preventDefault();
				e.stopPropagation();

				if (input) {
					input.classList.remove('captcha-success-border');
					input.classList.add('captcha-error-border');
					input.focus();
				}
				if (error) {
					error.innerText = userVal ? 'Incorrect CAPTCHA code. Please try again.' : 'Please enter the CAPTCHA code.';
					error.style.display = 'block';
				}
				window.refreshCaptcha(type);
				return false;
			}

			// If captcha is correct
			if (error) {
				error.style.display = 'none';
			}
			if (input) {
				input.classList.remove('captcha-error-border');
				input.classList.add('captcha-success-border');
			}
			alert('Form submitted successfully!');
			return true;
		});
	}

	function init() {
		// Enquire Form
		if (document.getElementById('enquireForm')) {
			window.refreshCaptcha('enquire');
			setupFormValidation('enquireForm', 'enquire');
		}

		// Careers Form
		const careersForm = document.querySelector('#why-join form');
		if (careersForm) {
			if (!careersForm.id) careersForm.id = 'careersForm';
			window.refreshCaptcha('careers');
			setupFormValidation('careersForm', 'careers');
		}
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', init);
	} else {
		init();
	}
})();
