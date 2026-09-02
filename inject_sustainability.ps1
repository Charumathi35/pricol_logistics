$htmlContent = @"
<style>
/* Sustainability 6-Point Custom Layout */
.sustainability-points-wrapper {
    max-width: 1140px;
    margin: 50px auto;
    font-family: var(--e-global-typography-primary-font-family), sans-serif;
    padding: 0 20px;
    background: #ffffff;
}

.sustainability-point {
    display: flex;
    align-items: stretch;
    border-bottom: 1px solid #eaedf2;
    padding: 35px 0;
    gap: 40px;
}

.sustainability-point:last-child {
    border-bottom: none;
}

.sustainability-point-number {
    font-size: 52px;
    font-weight: 700;
    color: #176B3C; /* Dark Green */
    line-height: 1;
    min-width: 70px;
    display: flex;
    align-items: flex-start;
    padding-top: 5px;
}

.sustainability-point-divider {
    width: 2px;
    background-color: #eaedf2;
    margin-right: 10px;
}

.sustainability-point-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    padding-top: 5px;
}

.sustainability-point-content h3 {
    font-size: 24px;
    font-weight: 700;
    color: #0b1126; /* Navy */
    margin: 0 0 15px 0;
    padding-bottom: 15px;
    position: relative;
    line-height: 1.3;
}

.sustainability-point-content h3::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 35px;
    height: 3px;
    background-color: #0b1126;
}

.sustainability-point-content p {
    font-size: 15px;
    color: #4b5563;
    line-height: 1.6;
    margin: 0;
}

.sustainability-point-image {
    width: 350px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
}

.sustainability-point-image img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
}

@media(max-width: 992px) {
    .sustainability-point {
        gap: 20px;
    }
    .sustainability-point-image {
        width: 280px;
    }
}

@media(max-width: 768px) {
    .sustainability-point {
        flex-direction: column;
        align-items: flex-start;
    }
    .sustainability-point-divider {
        display: none;
    }
    .sustainability-point-number {
        font-size: 40px;
        padding-top: 0;
        margin-bottom: 10px;
    }
    .sustainability-point-image {
        width: 100%;
        margin-top: 20px;
    }
    .sustainability-point-image img {
        height: auto;
        max-height: 300px;
    }
}
</style>

<div class="sustainability-points-wrapper">
    <!-- Point 1 -->
    <div class="sustainability-point">
        <div class="sustainability-point-number">01</div>
        <div class="sustainability-point-divider"></div>
        <div class="sustainability-point-content">
            <h3>Green Transportation</h3>
            <p>Improving transportation efficiency and reducing environmental impact through the exploration of electric vehicles (EVs) and alternative-fuel vehicles where operationally feasible, optimised transportation routes, improved fleet utilisation, preventive vehicle maintenance and fuel-efficient driving practices.</p>
        </div>
        <div class="sustainability-point-image">
            <img src="./images/A1-emerald-green-truck-on-forest-highway-modern-powe-2026-03-26-23-07-59-utc.jpg" alt="Green Transportation">
        </div>
    </div>
    
    <!-- Point 2 -->
    <div class="sustainability-point">
        <div class="sustainability-point-number">02</div>
        <div class="sustainability-point-divider"></div>
        <div class="sustainability-point-content">
            <h3>Smarter Supply Chains</h3>
            <p>Building more efficient and sustainable supply chains through improved load planning and shipment consolidation, efficient network planning, appropriate use of multimodal transportation and collaboration with customers to improve supply chain efficiency.</p>
        </div>
        <div class="sustainability-point-image">
            <img src="./images/A5-SUPPLY-CHAIN-freight-trucks-at-warehouse-loading-dock-industry-2026-03-18-05-02-30-utc.jpg" alt="Smarter Supply Chains">
        </div>
    </div>

    <!-- Point 3 -->
    <div class="sustainability-point">
        <div class="sustainability-point-number">03</div>
        <div class="sustainability-point-divider"></div>
        <div class="sustainability-point-content">
            <h3>Energy-Efficient Warehousing</h3>
            <p>Promoting energy-efficient warehouse operations through LED lighting, smart energy management, efficient space utilisation and smart warehouse technologies, while exploring renewable energy opportunities where feasible and encouraging responsible consumption of water and energy.</p>
        </div>
        <div class="sustainability-point-image">
            <img src="./images/warehouse-smart-logistics.jpg" alt="Energy-Efficient Warehousing">
        </div>
    </div>

    <!-- Point 4 -->
    <div class="sustainability-point">
        <div class="sustainability-point-number">04</div>
        <div class="sustainability-point-divider"></div>
        <div class="sustainability-point-content">
            <h3>Sustainable Packaging</h3>
            <p>Encouraging the use of recyclable and environmentally responsible packaging materials while reducing packaging waste through efficient design, material optimisation and right-sized packaging, promoting reusable packaging solutions where operationally feasible and collaborating with customers and partners to adopt more sustainable packaging practices across the supply chain.</p>
        </div>
        <div class="sustainability-point-image">
            <img src="./images/sustainability-packaging.jpg" alt="Sustainable Packaging">
        </div>
    </div>

    <!-- Point 5 -->
    <div class="sustainability-point">
        <div class="sustainability-point-number">05</div>
        <div class="sustainability-point-divider"></div>
        <div class="sustainability-point-content">
            <h3>Waste Management & Circular Economy</h3>
            <p>Promoting responsible waste management through waste segregation and disposal practices, recycling and reuse of operational materials, reducing single-use materials and supporting circular economy principles through resource optimisation.</p>
        </div>
        <div class="sustainability-point-image">
            <img src="./images/sustainability-recycling.jpg" alt="Waste Management">
        </div>
    </div>

    <!-- Point 6 -->
    <div class="sustainability-point">
        <div class="sustainability-point-number">06</div>
        <div class="sustainability-point-divider"></div>
        <div class="sustainability-point-content">
            <h3>Digital Transformation</h3>
            <p>Driving greater operational efficiency and reducing resource consumption through digital documentation, paperless workflows, electronic documentation, digital proof of delivery (ePOD), improved shipment visibility and technology-enabled planning.</p>
        </div>
        <div class="sustainability-point-image">
            <img src="./images/sustainability-worker.jpg" alt="Digital Transformation">
        </div>
    </div>
</div>
"@

$filePath = "c:\Users\1011\Downloads\pricollogistics-website-combined\sustainability.html"
$content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

# Use regex to find the start of the 6 points container and the start of the next major container
$pattern = '(?s)<div class="elementor-element elementor-element-22b1b85.*?<div class="elementor-element elementor-element-31f28075'

if ($content -match $pattern) {
    # We found the block. We need to preserve the start of the next block.
    $replacement = $htmlContent + "`n`t`t<div class=`"elementor-element elementor-element-31f28075"
    $newContent = $content -replace $pattern, $replacement
    [System.IO.File]::WriteAllText($filePath, $newContent, [System.Text.Encoding]::UTF8)
    Write-Host "Successfully injected the new 6-point layout into sustainability.html"
} else {
    Write-Host "Could not find the target section to replace."
}
