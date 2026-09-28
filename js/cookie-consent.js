/**
 * Pricol Logistics - Cookie Consent Manager
 * Robust event handlers, inline bindings, and event delegation for 100% click reliability.
 */
(function () {
	'use strict';

	const STORAGE_KEY = 'pricol_cookie_consent';

	function getConsent() {
		try {
			const item = localStorage.getItem(STORAGE_KEY);
			return item ? JSON.parse(item) : null;
		} catch (e) {
			return null;
		}
	}

	function saveConsent(type, preferences) {
		console.log('[Pricol Cookie Consent] Saving consent type:', type);
		const consentData = {
			consent: type,
			timestamp: new Date().toISOString(),
			preferences: preferences || {
				necessary: true,
				functional: type === 'all',
				analytics: type === 'all',
				performance: type === 'all',
				advertisement: type === 'all'
			}
		};
		try {
			localStorage.setItem(STORAGE_KEY, JSON.stringify(consentData));
		} catch (e) {
			console.error('Could not save cookie consent preference to localStorage:', e);
		}
		window.pricolHideBanner();
		window.pricolCloseCookieModal();
	}

	window.pricolShowBanner = function () {
		const banner = document.getElementById('pricol-cookie-banner');
		if (banner) {
			banner.style.setProperty('display', 'block', 'important');
		}
	};

	window.pricolHideBanner = function () {
		const banner = document.getElementById('pricol-cookie-banner');
		if (banner) {
			banner.style.setProperty('display', 'none', 'important');
		}
	};

	window.pricolOpenCookieModal = function () {
		console.log('[Pricol Cookie Consent] Opening preferences modal');
		const modal = document.getElementById('pricol-cookie-modal');
		if (modal) {
			modal.style.setProperty('display', 'flex', 'important');
			document.body.style.overflow = 'hidden';
		}
	};

	window.pricolCloseCookieModal = function () {
		console.log('[Pricol Cookie Consent] Closing preferences modal');
		const modal = document.getElementById('pricol-cookie-modal');
		if (modal) {
			modal.style.setProperty('display', 'none', 'important');
			document.body.style.overflow = '';
		}
	};

	window.pricolAcceptAllCookies = function () {
		console.log('[Pricol Cookie Consent] Accept All clicked');
		saveConsent('all', {
			necessary: true,
			functional: true,
			analytics: true,
			performance: true,
			advertisement: true
		});
	};

	window.pricolRejectAllCookies = function () {
		console.log('[Pricol Cookie Consent] Reject All clicked');
		saveConsent('rejected', {
			necessary: true,
			functional: false,
			analytics: false,
			performance: false,
			advertisement: false
		});
	};

	window.pricolSaveCookiePreferences = function () {
		console.log('[Pricol Cookie Consent] Save Preferences clicked');
		saveConsent('custom', {
			necessary: true,
			functional: false,
			analytics: false,
			performance: false,
			advertisement: false
		});
	};

	window.pricolResetCookieConsent = function () {
		console.log('[Pricol Cookie Consent] Resetting cookie consent');
		localStorage.removeItem(STORAGE_KEY);
		window.pricolShowBanner();
		window.pricolCloseCookieModal();
	};

	window.toggleCookieCategory = function (headerEl) {
		const item = headerEl.closest('.cookie-category-item');
		if (!item) return;
		const desc = item.querySelector('.cookie-category-desc');
		if (desc) {
			const isHidden = desc.style.display === 'none' || getComputedStyle(desc).display === 'none';
			desc.style.display = isHidden ? 'block' : 'none';
			if (isHidden) {
				item.classList.add('open');
			} else {
				item.classList.remove('open');
			}
		}
	};

	window.toggleCookieShowMore = function () {
		const moreText = document.getElementById('cookie-more-text');
		const btn = document.getElementById('cookie-show-more-btn');
		if (moreText && btn) {
			const isHidden = moreText.style.display === 'none' || getComputedStyle(moreText).display === 'none';
			if (isHidden) {
				moreText.style.display = 'inline';
				btn.innerText = 'Show less';
			} else {
				moreText.style.display = 'none';
				btn.innerText = 'Show more';
			}
		}
	};

	// Event Delegation for maximum click reliability
	document.addEventListener('click', function (e) {
		const target = e.target;
		if (!target) return;

		const closeBtn = target.closest('#pricol-cookie-modal-close, .cookie-modal-close');
		if (closeBtn) {
			window.pricolCloseCookieModal();
			return;
		}

		const customizeBtn = target.closest('#pricol-cookie-customize-btn, .cookie-btn-customize');
		if (customizeBtn) {
			window.pricolOpenCookieModal();
			return;
		}

		const acceptBtn = target.closest('#pricol-cookie-accept-btn, #pricol-cookie-modal-accept');
		if (acceptBtn) {
			window.pricolAcceptAllCookies();
			return;
		}

		const rejectBtn = target.closest('#pricol-cookie-reject-btn, #pricol-cookie-modal-reject');
		if (rejectBtn) {
			window.pricolRejectAllCookies();
			return;
		}

		const saveBtn = target.closest('#pricol-cookie-modal-save');
		if (saveBtn) {
			window.pricolSaveCookiePreferences();
			return;
		}

		if (target.id === 'pricol-cookie-modal') {
			window.pricolCloseCookieModal();
		}
	});

	function init() {
		const consent = getConsent();
		if (!consent) {
			window.pricolShowBanner();
		} else {
			window.pricolHideBanner();
		}
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', init);
	} else {
		init();
	}
})();
