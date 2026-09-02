$newSection = @'
		<!-- Custom Mission & Vision Parallax Section -->
		<style>
		/* Mission Vision Parallax Section */
		.mv-parallax-section {
			position: relative;
			background-image: url('./images/Transhipjpg-016.jpg');
			background-size: cover;
			background-position: center center;
			background-attachment: fixed;
			min-height: 100vh;
			width: 100%;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			overflow: hidden;
		}
		.mv-parallax-section::before {
			content: '';
			position: absolute;
			inset: 0;
			background: rgba(10, 10, 20, 0.60);
			z-index: 1;
		}
		.mv-parallax-section .mv-inner {
			position: relative;
			z-index: 2;
			width: 100%;
			max-width: 1100px;
			margin: 0 auto;
			padding: 120px 40px;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			min-height: 100vh;
		}
		/* MISSION - top left */
		.mv-mission-block {
			display: flex;
			flex-direction: column;
			align-items: flex-start;
			max-width: 400px;
			opacity: 0;
			transform: translateY(40px);
			transition: opacity 0.8s ease, transform 0.8s ease;
		}
		.mv-mission-block.visible {
			opacity: 1;
			transform: translateY(0);
		}
		/* VISION - bottom right */
		.mv-vision-block {
			display: flex;
			flex-direction: column;
			align-items: flex-end;
			align-self: flex-end;
			max-width: 400px;
			text-align: right;
			opacity: 0;
			transform: translateY(40px);
			transition: opacity 0.8s ease 0.3s, transform 0.8s ease 0.3s;
		}
		.mv-vision-block.visible {
			opacity: 1;
			transform: translateY(0);
		}
		/* Label Row with red line */
		.mv-label-row {
			display: flex;
			align-items: center;
			gap: 12px;
			margin-bottom: 20px;
			width: 100%;
		}
		.mv-mission-block .mv-label-row {
			flex-direction: row;
		}
		.mv-vision-block .mv-label-row {
			flex-direction: row-reverse;
			justify-content: flex-end;
		}
		.mv-label {
			font-family: 'Manrope', sans-serif;
			font-size: 28px;
			font-weight: 800;
			color: #ffffff;
			letter-spacing: 3px;
			text-transform: uppercase;
			white-space: nowrap;
		}
		.mv-red-dot {
			width: 10px;
			height: 10px;
			border-radius: 50%;
			background-color: #E1261C;
			flex-shrink: 0;
		}
		.mv-red-line {
			flex: 1;
			height: 2px;
			background-color: #E1261C;
			min-width: 80px;
			max-width: 260px;
		}
		/* Paragraph text */
		.mv-text {
			font-family: 'Manrope', sans-serif;
			font-size: 15px;
			font-weight: 400;
			color: rgba(255, 255, 255, 0.88);
			line-height: 1.8;
			margin: 0;
		}
		@media (max-width: 768px) {
			.mv-parallax-section {
				background-attachment: scroll;
			}
			.mv-parallax-section .mv-inner {
				padding: 80px 24px;
			}
			.mv-vision-block {
				align-self: flex-start;
				align-items: flex-start;
				text-align: left;
			}
			.mv-vision-block .mv-label-row {
				flex-direction: row;
				justify-content: flex-start;
			}
			.mv-mission-block, .mv-vision-block {
				max-width: 100%;
			}
		}
		</style>

		<section class="mv-parallax-section" id="mv-section">
			<div class="mv-inner">
				<!-- MISSION block -->
				<div class="mv-mission-block" id="mv-mission">
					<div class="mv-label-row">
						<span class="mv-label">Mission</span>
						<span class="mv-red-dot"></span>
						<span class="mv-red-line"></span>
					</div>
					<p class="mv-text">To create seamless, scalable and sustainable solutions across our core verticals by combining deep domain knowledge, human-first values and a commitment to service excellence as one integrated global family.</p>
				</div>

				<!-- VISION block -->
				<div class="mv-vision-block" id="mv-vision">
					<div class="mv-label-row">
						<span class="mv-label">Vision</span>
						<span class="mv-red-dot"></span>
						<span class="mv-red-line"></span>
					</div>
					<p class="mv-text">To be one of the world&#8217;s most trusted and respected integrated logistics and services enterprises &#8211; driven by people, powered by innovation and united by a legacy of excellence.</p>
				</div>
			</div>
		</section>

		<script>
		(function() {
			function onScroll() {
				var section = document.getElementById('mv-section');
				var mission = document.getElementById('mv-mission');
				var vision = document.getElementById('mv-vision');
				if (!section) return;
				var rect = section.getBoundingClientRect();
				var winH = window.innerHeight;
				// Trigger mission when section is 70% in view
				if (rect.top < winH * 0.85) {
					mission && mission.classList.add('visible');
				}
				// Trigger vision a bit later
				if (rect.top < winH * 0.55) {
					vision && vision.classList.add('visible');
				}
			}
			window.addEventListener('scroll', onScroll, { passive: true });
			// Check on load too
			onScroll();
		})();
		</script>
		<!-- End Custom Mission & Vision Parallax Section -->
'@

$filePath = "c:\Users\1011\Downloads\pricollogistics-website-combined\pricol-group.html"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# We'll insert the new section right before the 1e4b7dd1 container (the navigation bar that comes after the banner)
$targetPattern = '<div class="elementor-element elementor-element-1e4b7dd1 e-flex e-con-boxed e-con e-parent"'
$replacement = $newSection + "`n`t`t" + '<div class="elementor-element elementor-element-1e4b7dd1 e-flex e-con-boxed e-con e-parent"'

if ($content -match [regex]::Escape($targetPattern)) {
    $newContent = $content.Replace($targetPattern, $replacement)
    [System.IO.File]::WriteAllText($filePath, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host "SUCCESS: Mission Vision parallax section injected."
} else {
    Write-Host "Pattern not found. Trying alternate..."
    $content | Select-String "1e4b7dd1"
}
