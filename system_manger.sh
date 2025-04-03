#!/bin/bash

# Configuration file path
CONFIG_FILE="$HOME/.system_manager.conf"

# Default settings
DEFAULT_MENU="rofi"
DEFAULT_DIR="$HOME"
DEFAULT_ITEMS=10
THEME="light" # Default theme
LANGUAGE="en" # Default language
BACKUP_DIR="$HOME/backups"
LOG_FILE="$HOME/system_manager.log"

# Load configuration file if it exists
load_config() {
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    else
        # Create a default configuration file if it doesn't exist
        echo "DEFAULT_MENU=\"$DEFAULT_MENU\"" > "$CONFIG_FILE"
        echo "DEFAULT_DIR=\"$DEFAULT_DIR\"" >> "$CONFIG_FILE"
        echo "DEFAULT_ITEMS=$DEFAULT_ITEMS" >> "$CONFIG_FILE"
        echo "THEME=\"$THEME\"" >> "$CONFIG_FILE"
        echo "LANGUAGE=\"$LANGUAGE\"" >> "$CONFIG_FILE"
        echo "BACKUP_DIR=\"$BACKUP_DIR\"" >> "$CONFIG_FILE"
    fi
}

# Function to display the main menu
main_menu() {
    choice=$(echo -e "1. Navigator\n2. Search Files\n3. Manage Bookmarks\n4. WiFi Management\n5. System Power\n6. Recent Files\n7. Manage Favorites\n8. System Manager\n9. Network Traffic\n10. Volume Control\n11. Mathematics Equations\n12. Number Conversion\n13. Weather Information\n14. Reminders and To-Do List\n15. System Backup\n16. Custom Themes\n17. Integration with External Tools\n18. Help and Documentation\n19. Error Logging and Debugging\n20. Multi-Language Support\n21. Interactive Tutorial\n22. System Updates\n23. Community Features\n24. Quit" | rofi -dmenu -i -p "Choose an option" -lines 24 -width 50)
    handle_choice "$choice"
}

# Function to handle user choice
handle_choice() {
    case "$1" in
        "1. Navigator")
            navigator
            ;;
        "2. Search Files")
            search_files
            ;;
        "3. Manage Bookmarks")
            manage_bookmarks
            ;;
        "4. WiFi Management")
            wifi_management
            ;;
        "5. System Power")
            system_power
            ;;
        "6. Recent Files")
            recent_files
            ;;
        "7. Manage Favorites")
            manage_favorites
            ;;
        "8. System Manager")
            system_manager
            ;;
        "9. Network Traffic")
            network_traffic
            ;;
        "10. Volume Control")
            volume_control
            ;;
        "11. Mathematics Equations")
            mathematics_equations
            ;;
        "12. Number Conversion")
            number_conversion
            ;;
        "13. Weather Information")
            weather_information
            ;;
        "14. Reminders and To-Do List")
            reminders_and_todo_list
            ;;
        "15. System Backup")
            system_backup
            ;;
        "16. Custom Themes")
            custom_themes
            ;;
        "17. Integration with External Tools")
            integration_with_external_tools
            ;;
        "18. Help and Documentation")
            help_and_documentation
            ;;
        "19. Error Logging and Debugging")
            error_logging_and_debugging
            ;;
        "20. Multi-Language Support")
            multi_language_support
            ;;
        "21. Interactive Tutorial")
            interactive_tutorial
            ;;
        "22. System Updates")
            system_updates
            ;;
        "23. Community Features")
            community_features
            ;;
        "24. Quit")
            notify-send "Exiting System Manager."
            exit 0
            ;;
        *)
            notify-send "Invalid option selected. Returning to menu."
            main_menu
            ;;
    esac
}

# Function for Navigator
navigator() {
    cd "$DEFAULT_DIR" || return
    notify-send "Navigator" "Navigating to $DEFAULT_DIR"
    # Return to main menu
    main_menu
}

# Function for Search Files
search_files() {
    while true; do
        # Prompt the user to enter a search query or go back
        query=$(echo -e "Back to Main Menu" | rofi -dmenu -p "Enter file name to search" -lines 1 -width 40)
        
        # Handle the "Back to Main Menu" option
        if [[ "$query" == "Back to Main Menu" ]]; then
            main_menu
            return
        fi

        # Check if the user entered a query
        if [[ -z "$query" ]]; then
            notify-send "No search query entered. Operation canceled."
            # Return to main menu
            main_menu
            return
        fi

        # Find files matching the query
        results=$(find "$DEFAULT_DIR" -type f -iname "*$query*" 2>/dev/null | head -n "$DEFAULT_ITEMS")
        if [[ -z "$results" ]]; then
            notify-send "No files found matching '$query' in $DEFAULT_DIR."
            continue
        fi

        # Add a "Back" option to the search results
        results_with_back=$(echo -e "$results\nBack to Main Menu")
        selected_file=$(echo "$results_with_back" | rofi -dmenu -i -p "Select a file" -width 80 -lines "$DEFAULT_ITEMS")

        if [[ -z "$selected_file" ]]; then
            notify-send "No file selected. Operation canceled."
            continue
        fi

        # Handle the "Back to Main Menu" option
        if [[ "$selected_file" == "Back to Main Menu" ]]; then
            main_menu
            return
        fi

        # Open the selected file
        xdg-open "$selected_file" >/dev/null 2>&1 &
        notify-send "Opening file: $selected_file"
    done
}

# Function for Manage Bookmarks
manage_bookmarks() {
    while true; do
        choice=$(echo -e "1. Add Bookmark\n2. Remove Bookmark\n3. List Bookmarks\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Add Bookmark")
                notify-send "Add Bookmark" "Feature under construction."
                ;;
            "2. Remove Bookmark")
                notify-send "Remove Bookmark" "Feature under construction."
                ;;
            "3. List Bookmarks")
                notify-send "List Bookmarks" "Feature under construction."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for WiFi Management
wifi_management() {
    while true; do
        choice=$(echo -e "1. Connect to WiFi\n2. Disconnect from WiFi\n3. List Available Networks\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Connect to WiFi")
                networks=$(nmcli dev wifi list | rofi -dmenu -i -p "Select WiFi Network" -lines "$DEFAULT_ITEMS")
                if [[ -z "$networks" ]]; then
                    notify-send "No network selected. Operation canceled."
                    continue
                fi
                selected_network=$(echo "$networks" | awk '{print $1}')
                nmcli dev wifi connect "$selected_network"
                notify-send "WiFi Management" "Connected to $selected_network"
                ;;
            "2. Disconnect from WiFi")
                nmcli dev disconnect
                notify-send "WiFi Management" "Disconnected from WiFi."
                ;;
            "3. List Available Networks")
                nmcli dev wifi list | rofi -dmenu -i -p "Available Networks" -lines "$DEFAULT_ITEMS"
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for System Power
system_power() {
    while true; do
        choice=$(echo -e "1. Shutdown\n2. Reboot\n3. Suspend\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Shutdown")
                systemctl poweroff
                ;;
            "2. Reboot")
                systemctl reboot
                ;;
            "3. Suspend")
                systemctl suspend
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Recent Files
recent_files() {
    while true; do
        recent=$(ls -t "$DEFAULT_DIR" | head -n "$DEFAULT_ITEMS")
        selected_file=$(echo -e "$recent\nBack to Main Menu" | rofi -dmenu -i -p "Select a recent file" -lines "$DEFAULT_ITEMS")
        if [[ -z "$selected_file" ]]; then
            notify-send "No file selected. Operation canceled."
            continue
        fi

        # Handle the "Back to Main Menu" option
        if [[ "$selected_file" == "Back to Main Menu" ]]; then
            main_menu
            return
        fi

        # Open the selected file
        xdg-open "$DEFAULT_DIR/$selected_file" >/dev/null 2>&1 &
        notify-send "Opening file: $selected_file"
    done
}

# Function for Manage Favorites
manage_favorites() {
    while true; do
        choice=$(echo -e "1. Add Favorite\n2. Remove Favorite\n3. List Favorites\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Add Favorite")
                notify-send "Add Favorite" "Feature under construction."
                ;;
            "2. Remove Favorite")
                notify-send "Remove Favorite" "Feature under construction."
                ;;
            "3. List Favorites")
                notify-send "List Favorites" "Feature under construction."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for System Manager
system_manager() {
    while true; do
        choice=$(echo -e "1. System Info\n2. Update System\n3. Clean System\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. System Info")
                notify-send "System Info" "Feature under construction."
                ;;
            "2. Update System")
                notify-send "Update System" "Feature under construction."
                ;;
            "3. Clean System")
                notify-send "Clean System" "Feature under construction."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Network Traffic
network_traffic() {
    while true; do
        traffic=$(iftop -n -t -s 5)
        choice=$(echo -e "$traffic\nBack to Main Menu" | rofi -dmenu -i -p "Network Traffic" -lines "$DEFAULT_ITEMS")
        if [[ "$choice" == "Back to Main Menu" ]]; then
            main_menu
            return
        fi
    done
}

# Function for Volume Control
volume_control() {
    while true; do
        volume=$(pactl list sinks | grep Volume | head -n 1 | awk '{print $5}')
        choice=$(echo -e "1. Increase Volume\n2. Decrease Volume\n3. Mute\n4. Unmute\n5. Back to Main Menu" | rofi -dmenu -i -p "Volume: $volume" -lines 5)
        case "$choice" in
            "1. Increase Volume")
                pactl set-sink-volume @DEFAULT_SINK@ +5%
                ;;
            "2. Decrease Volume")
                pactl set-sink-volume @DEFAULT_SINK@ -5%
                ;;
            "3. Mute")
                pactl set-sink-mute @DEFAULT_SINK@ 1
                ;;
            "4. Unmute")
                pactl set-sink-mute @DEFAULT_SINK@ 0
                ;;
            "5. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Mathematics Equations
mathematics_equations() {
    while true; do
        # List of equations
        equation=$(echo -e "Binomial Theorem\nExpansion of a Sum\nFourier Series\nPythagorean Theorem\nQuadratic Formula\nTaylor Expansion\nTrig Identity 1\nTrig Identity 2\nAccelerated Motion\nCompound Interest\nFirst Order Logic\nGaussian Integral\nMode Locking Integral\nRotation\nAbsolute Value\nDistributive\nFirst Law of Exponents\nFirst Property of Radicals\nFraction Addition\nFraction Multiplication\nFractional Exponents\nLimit\nNegative Exponent\nPolynomial\nPower of a Power\nPower of a Quotient\nProduct of a Sum and Difference\nSecond Law of Exponents\nVector Relation\nNewton's Law of Gravitation\nNewton's Second Law\nPlasma Dispersion\nTaylor Series\nDe Moivre's Theorem\nTrig Identity 3\nTrig Identity 4\nBack to Main Menu" | rofi -dmenu -i -p "Select an Equation" -lines 20 -width 80)

        case "$equation" in
            "Binomial Theorem")
                notify-send "Binomial Theorem" "Equation: (a + b)^n = Σ [n! / (k!(n-k)!)] * a^(n-k) * b^k"
                equation_options "$equation"
                ;;
            "Expansion of a Sum")
                notify-send "Expansion of a Sum" "Equation: (a + b)^2 = a^2 + 2ab + b^2"
                equation_options "$equation"
                ;;
            "Fourier Series")
                notify-send "Fourier Series" "Equation: f(x) = a₀/2 + Σ [aₙ cos(nx) + bₙ sin(nx)]"
                equation_options "$equation"
                ;;
            "Pythagorean Theorem")
                notify-send "Pythagorean Theorem" "Equation: c = √(a² + b²)"
                equation_options "$equation"
                ;;
            "Quadratic Formula")
                notify-send "Quadratic Formula" "Equation: x = [-b ± √(b² - 4ac)] / (2a)"
                equation_options "$equation"
                ;;
            "Taylor Expansion")
                notify-send "Taylor Expansion" "Equation: f(x) = f(a) + f'(a)(x-a) + f''(a)(x-a)²/2! + ..."
                equation_options "$equation"
                ;;
            "Trig Identity 1")
                notify-send "Trig Identity 1" "Equation: sin²θ + cos²θ = 1"
                equation_options "$equation"
                ;;
            "Trig Identity 2")
                notify-send "Trig Identity 2" "Equation: tanθ = sinθ / cosθ"
                equation_options "$equation"
                ;;
            "Accelerated Motion")
                notify-send "Accelerated Motion" "Equation: v = u + at"
                equation_options "$equation"
                ;;
            "Compound Interest")
                notify-send "Compound Interest" "Equation: A = P(1 + r/n)^(nt)"
                equation_options "$equation"
                ;;
            "First Order Logic")
                notify-send "First Order Logic" "Equation: ∀x (P(x) → Q(x))"
                equation_options "$equation"
                ;;
            "Gaussian Integral")
                notify-send "Gaussian Integral" "Equation: ∫ e^(-x²) dx = √π"
                equation_options "$equation"
                ;;
            "Mode Locking Integral")
                notify-send "Mode Locking Integral" "Equation: ∫ f(x) dx = F(x) + C"
                equation_options "$equation"
                ;;
            "Rotation")
                notify-send "Rotation" "Equation: x' = x cosθ - y sinθ, y' = x sinθ + y cosθ"
                equation_options "$equation"
                ;;
            "Absolute Value")
                notify-send "Absolute Value" "Equation: |x| = x if x ≥ 0, -x if x < 0"
                equation_options "$equation"
                ;;
            "Distributive")
                notify-send "Distributive" "Equation: a(b + c) = ab + ac"
                equation_options "$equation"
                ;;
            "First Law of Exponents")
                notify-send "First Law of Exponents" "Equation: a^m * a^n = a^(m+n)"
                equation_options "$equation"
                ;;
            "First Property of Radicals")
                notify-send "First Property of Radicals" "Equation: √(ab) = √a * √b"
                equation_options "$equation"
                ;;
            "Fraction Addition")
                notify-send "Fraction Addition" "Equation: a/b + c/d = (ad + bc) / bd"
                equation_options "$equation"
                ;;
            "Fraction Multiplication")
                notify-send "Fraction Multiplication" "Equation: (a/b) * (c/d) = (ac) / (bd)"
                equation_options "$equation"
                ;;
            "Fractional Exponents")
                notify-send "Fractional Exponents" "Equation: a^(m/n) = (ⁿ√a)^m"
                equation_options "$equation"
                ;;
            "Limit")
                notify-send "Limit" "Equation: lim (x→a) f(x) = L"
                equation_options "$equation"
                ;;
            "Negative Exponent")
                notify-send "Negative Exponent" "Equation: a^(-n) = 1 / a^n"
                equation_options "$equation"
                ;;
            "Polynomial")
                notify-send "Polynomial" "Equation: P(x) = aₙxⁿ + aₙ₋₁xⁿ⁻¹ + ... + a₁x + a₀"
                equation_options "$equation"
                ;;
            "Power of a Power")
                notify-send "Power of a Power" "Equation: (a^m)^n = a^(m*n)"
                equation_options "$equation"
                ;;
            "Power of a Quotient")
                notify-send "Power of a Quotient" "Equation: (a/b)^n = a^n / b^n"
                equation_options "$equation"
                ;;
            "Product of a Sum and Difference")
                notify-send "Product of a Sum and Difference" "Equation: (a + b)(a - b) = a² - b²"
                equation_options "$equation"
                ;;
            "Second Law of Exponents")
                notify-send "Second Law of Exponents" "Equation: a^m / a^n = a^(m-n)"
                equation_options "$equation"
                ;;
            "Vector Relation")
                notify-send "Vector Relation" "Equation: |A + B| ≤ |A| + |B|"
                equation_options "$equation"
                ;;
            "Newton's Law of Gravitation")
                notify-send "Newton's Law of Gravitation" "Equation: F = G (m₁m₂) / r²"
                equation_options "$equation"
                ;;
            "Newton's Second Law")
                notify-send "Newton's Second Law" "Equation: F = ma"
                equation_options "$equation"
                ;;
            "Plasma Dispersion")
                notify-send "Plasma Dispersion" "Equation: ω² = ωₚ² + k²c²"
                equation_options "$equation"
                ;;
            "Taylor Series")
                notify-send "Taylor Series" "Equation: f(x) = Σ [fⁿ(a) / n!] (x - a)^n"
                equation_options "$equation"
                ;;
            "De Moivre's Theorem")
                notify-send "De Moivre's Theorem" "Equation: (cosθ + i sinθ)^n = cos(nθ) + i sin(nθ)"
                equation_options "$equation"
                ;;
            "Trig Identity 3")
                notify-send "Trig Identity 3" "Equation: sin(A ± B) = sinA cosB ± cosA sinB"
                equation_options "$equation"
                ;;
            "Trig Identity 4")
                notify-send "Trig Identity 4" "Equation: cos(A ± B) = cosA cosB ∓ sinA sinB"
                equation_options "$equation"
                ;;
            "Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid selection. Returning to menu."
                ;;
        esac
    done
}

# Function to handle equation options
equation_options() {
    equation_name="$1"
    while true; do
        choice=$(echo -e "1. Calculate\n2. Back to Equations" | rofi -dmenu -i -p "$equation_name" -lines 2)
        case "$choice" in
            "1. Calculate")
                case "$equation_name" in
                    "Pythagorean Theorem")
                        pythagorean_theorem
                        ;;
                    "Quadratic Formula")
                        quadratic_formula
                        ;;
                    "Compound Interest")
                        compound_interest
                        ;;
                    # Add cases for other equations here...
                    *)
                        notify-send "Calculation not implemented yet."
                        ;;
                esac
                ;;
            "2. Back to Equations")
                mathematics_equations
                return
                ;;
            *)
                notify-send "Invalid selection. Returning to menu."
                ;;
        esac
    done
}

# Function for Pythagorean Theorem
pythagorean_theorem() {
    # Prompt the user for the sides of the triangle
    a=$(rofi -dmenu -p "Enter side a" -lines 1 -width 40)
    b=$(rofi -dmenu -p "Enter side b" -lines 1 -width 40)

    # Validate inputs
    if ! [[ "$a" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$b" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        notify-send "Error" "Invalid input. Please enter numeric values."
        return
    fi

    # Compute the hypotenuse
    c=$(echo "scale=2; sqrt($a^2 + $b^2)" | bc)

    # Display the result
    notify-send "Pythagorean Theorem" "Hypotenuse (c) = $c"
}

# Function for Quadratic Formula
quadratic_formula() {
    # Prompt the user for coefficients a, b, and c
    a=$(rofi -dmenu -p "Enter coefficient a" -lines 1 -width 40)
    b=$(rofi -dmenu -p "Enter coefficient b" -lines 1 -width 40)
    c=$(rofi -dmenu -p "Enter coefficient c" -lines 1 -width 40)

    # Validate inputs
    if ! [[ "$a" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$b" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$c" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        notify-send "Error" "Invalid input. Please enter numeric values."
        return
    fi

    # Compute the discriminant
    discriminant=$(echo "scale=2; $b^2 - 4*$a*$c" | bc)

    if (( $(echo "$discriminant < 0" | bc -l) )); then
        notify-send "Quadratic Formula" "No real roots (discriminant < 0)"
    else
        # Compute the roots
        root1=$(echo "scale=2; (-$b + sqrt($discriminant)) / (2*$a)" | bc)
        root2=$(echo "scale=2; (-$b - sqrt($discriminant)) / (2*$a)" | bc)

        # Display the results
        notify-send "Quadratic Formula" "Root 1 = $root1\nRoot 2 = $root2"
    fi
}

# Function for Compound Interest
compound_interest() {
    # Prompt the user for principal, rate, time, and compounding frequency
    principal=$(rofi -dmenu -p "Enter principal amount" -lines 1 -width 40)
    rate=$(rofi -dmenu -p "Enter annual interest rate (as a decimal)" -lines 1 -width 40)
    time=$(rofi -dmenu -p "Enter time in years" -lines 1 -width 40)
    n=$(rofi -dmenu -p "Enter compounding frequency per year" -lines 1 -width 40)

    # Validate inputs
    if ! [[ "$principal" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$rate" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$time" =~ ^[0-9]+(\.[0-9]+)?$ ]] || ! [[ "$n" =~ ^[0-9]+$ ]]; then
        notify-send "Error" "Invalid input. Please enter numeric values."
        return
    fi

    # Compute the compound interest
    amount=$(echo "scale=2; $principal * (1 + $rate/$n)^($n*$time)" | bc)

    # Display the result
    notify-send "Compound Interest" "Final Amount = $amount"
}

# Function for Number Conversion
number_conversion() {
    while true; do
        choice=$(echo -e "1. Decimal to Hexadecimal\n2. Hexadecimal to Decimal\n3. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 3)
        case "$choice" in
            "1. Decimal to Hexadecimal")
                decimal_to_hex
                ;;
            "2. Hexadecimal to Decimal")
                hex_to_decimal
                ;;
            "3. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Decimal to Hexadecimal Conversion
decimal_to_hex() {
    while true; do
        decimal=$(rofi -dmenu -p "Enter a decimal number" -lines 1 -width 40)
        
        # Handle "Back" option
        if [[ "$decimal" == "Back" ]]; then
            number_conversion
            return
        fi

        # Validate input
        if ! [[ "$decimal" =~ ^[0-9]+$ ]]; then
            notify-send "Error" "Invalid input. Please enter a valid decimal number."
            continue
        fi

        # Convert decimal to hexadecimal
        hex=$(printf "%X" "$decimal")
        notify-send "Decimal to Hexadecimal" "Decimal: $decimal\nHexadecimal: 0x$hex"

        # Prompt to continue or go back
        choice=$(echo -e "1. Convert Another\n2. Back to Number Conversion" | rofi -dmenu -i -p "Choose an option" -lines 2)
        case "$choice" in
            "1. Convert Another")
                continue
                ;;
            "2. Back to Number Conversion")
                number_conversion
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Hexadecimal to Decimal Conversion
hex_to_decimal() {
    while true; do
        hex=$(rofi -dmenu -p "Enter a hexadecimal number (without 0x)" -lines 1 -width 40)
        
        # Handle "Back" option
        if [[ "$hex" == "Back" ]]; then
            number_conversion
            return
        fi

        # Validate input
        if ! [[ "$hex" =~ ^[0-9A-Fa-f]+$ ]]; then
            notify-send "Error" "Invalid input. Please enter a valid hexadecimal number."
            continue
        fi

        # Convert hexadecimal to decimal
        decimal=$((16#$hex))
        notify-send "Hexadecimal to Decimal" "Hexadecimal: 0x$hex\nDecimal: $decimal"

        # Prompt to continue or go back
        choice=$(echo -e "1. Convert Another\n2. Back to Number Conversion" | rofi -dmenu -i -p "Choose an option" -lines 2)
        case "$choice" in
            "1. Convert Another")
                continue
                ;;
            "2. Back to Number Conversion")
                number_conversion
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Weather Information
weather_information() {
    while true; do
        choice=$(echo -e "1. Get Current Weather\n2. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 2)
        case "$choice" in
            "1. Get Current Weather")
                city=$(rofi -dmenu -p "Enter city name" -lines 1 -width 40)
                if [[ -z "$city" ]]; then
                    notify-send "Error" "City name cannot be empty."
                    continue
                fi
                weather=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=YOUR_API_KEY&units=metric")
                if [[ -z "$weather" ]]; then
                    notify-send "Error" "Failed to fetch weather data."
                    continue
                fi
                temperature=$(echo "$weather" | jq -r '.main.temp')
                humidity=$(echo "$weather" | jq -r '.main.humidity')
                wind_speed=$(echo "$weather" | jq -r '.wind.speed')
                notify-send "Weather in $city" "Temperature: $temperature°C\nHumidity: $humidity%\nWind Speed: $wind_speed m/s"
                ;;
            "2. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Reminders and To-Do List
reminders_and_todo_list() {
    while true; do
        choice=$(echo -e "1. Add Reminder\n2. Edit Reminder\n3. Delete Reminder\n4. List Reminders\n5. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 5)
        case "$choice" in
            "1. Add Reminder")
                reminder=$(rofi -dmenu -p "Enter reminder text" -lines 1 -width 40)
                if [[ -z "$reminder" ]]; then
                    notify-send "Error" "Reminder text cannot be empty."
                    continue
                fi
                echo "$reminder" >> "$HOME/reminders.txt"
                notify-send "Reminder Added" "Reminder: $reminder"
                ;;
            "2. Edit Reminder")
                reminders=$(cat "$HOME/reminders.txt")
                selected_reminder=$(echo -e "$reminders\nBack to Main Menu" | rofi -dmenu -i -p "Select a reminder to edit" -lines 10)
                if [[ "$selected_reminder" == "Back to Main Menu" ]]; then
                    main_menu
                    return
                fi
                new_reminder=$(rofi -dmenu -p "Edit reminder" -lines 1 -width 40 -filter "$selected_reminder")
                if [[ -z "$new_reminder" ]]; then
                    notify-send "Error" "Reminder text cannot be empty."
                    continue
                fi
                sed -i "s/$selected_reminder/$new_reminder/" "$HOME/reminders.txt"
                notify-send "Reminder Edited" "Old: $selected_reminder\nNew: $new_reminder"
                ;;
            "3. Delete Reminder")
                reminders=$(cat "$HOME/reminders.txt")
                selected_reminder=$(echo -e "$reminders\nBack to Main Menu" | rofi -dmenu -i -p "Select a reminder to delete" -lines 10)
                if [[ "$selected_reminder" == "Back to Main Menu" ]]; then
                    main_menu
                    return
                fi
                sed -i "/$selected_reminder/d" "$HOME/reminders.txt"
                notify-send "Reminder Deleted" "Reminder: $selected_reminder"
                ;;
            "4. List Reminders")
                reminders=$(cat "$HOME/reminders.txt")
                if [[ -z "$reminders" ]]; then
                    notify-send "Reminders" "No reminders found."
                else
                    notify-send "Reminders" "$reminders"
                fi
                ;;
            "5. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for System Backup
system_backup() {
    while true; do
        choice=$(echo -e "1. Create Backup\n2. Restore Backup\n3. Schedule Backup\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Create Backup")
                backup_name=$(rofi -dmenu -p "Enter backup name" -lines 1 -width 40)
                if [[ -z "$backup_name" ]]; then
                    notify-send "Error" "Backup name cannot be empty."
                    continue
                fi
                mkdir -p "$BACKUP_DIR/$backup_name"
                rsync -a --exclude={'/proc','/sys','/dev','/tmp','/run','/mnt','/media','/lost+found'} / "$BACKUP_DIR/$backup_name"
                notify-send "Backup Created" "Backup: $backup_name"
                ;;
            "2. Restore Backup")
                backups=$(ls "$BACKUP_DIR")
                if [[ -z "$backups" ]]; then
                    notify-send "Error" "No backups found."
                    continue
                fi
                selected_backup=$(echo -e "$backups\nBack to Main Menu" | rofi -dmenu -i -p "Select a backup to restore" -lines 10)
                if [[ "$selected_backup" == "Back to Main Menu" ]]; then
                    main_menu
                    return
                fi
                rsync -a "$BACKUP_DIR/$selected_backup/" /
                notify-send "Backup Restored" "Backup: $selected_backup"
                ;;
            "3. Schedule Backup")
                cron_job="0 0 * * * rsync -a --exclude={'/proc','/sys','/dev','/tmp','/run','/mnt','/media','/lost+found'} / $BACKUP_DIR/backup_\$(date +\%Y\%m\%d)"
                (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
                notify-send "Backup Scheduled" "Backup will run daily at midnight."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Custom Themes
custom_themes() {
    while true; do
        choice=$(echo -e "1. Light Theme\n2. Dark Theme\n3. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 3)
        case "$choice" in
            "1. Light Theme")
                THEME="light"
                sed -i "s/THEME=.*/THEME=\"$THEME\"/" "$CONFIG_FILE"
                notify-send "Theme Changed" "Light theme applied."
                ;;
            "2. Dark Theme")
                THEME="dark"
                sed -i "s/THEME=.*/THEME=\"$THEME\"/" "$CONFIG_FILE"
                notify-send "Theme Changed" "Dark theme applied."
                ;;
            "3. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Integration with External Tools
integration_with_external_tools() {
    while true; do
        choice=$(echo -e "1. Git\n2. Docker\n3. Cloud Services\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Git")
                git_command=$(rofi -dmenu -p "Enter Git command" -lines 1 -width 40)
                if [[ -z "$git_command" ]]; then
                    notify-send "Error" "Git command cannot be empty."
                    continue
                fi
                eval "git $git_command"
                ;;
            "2. Docker")
                docker_command=$(rofi -dmenu -p "Enter Docker command" -lines 1 -width 40)
                if [[ -z "$docker_command" ]]; then
                    notify-send "Error" "Docker command cannot be empty."
                    continue
                fi
                eval "docker $docker_command"
                ;;
            "3. Cloud Services")
                cloud_service=$(rofi -dmenu -p "Enter Cloud Service (AWS, GCP, Azure)" -lines 1 -width 40)
                if [[ -z "$cloud_service" ]]; then
                    notify-send "Error" "Cloud service cannot be empty."
                    continue
                fi
                notify-send "Cloud Service" "Selected: $cloud_service"
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Help and Documentation
help_and_documentation() {
    while true; do
        choice=$(echo -e "1. Commands\n2. Examples\n3. Tutorials\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Commands")
                notify-send "Commands" "List of available commands:\n1. Navigator\n2. Search Files\n3. Manage Bookmarks\n4. WiFi Management\n5. System Power\n6. Recent Files\n7. Manage Favorites\n8. System Manager\n9. Network Traffic\n10. Volume Control\n11. Mathematics Equations\n12. Number Conversion\n13. Weather Information\n14. Reminders and To-Do List\n15. System Backup\n16. Custom Themes\n17. Integration with External Tools\n18. Help and Documentation\n19. Error Logging and Debugging\n20. Multi-Language Support\n21. Interactive Tutorial\n22. System Updates\n23. Community Features\n24. Quit"
                ;;
            "2. Examples")
                notify-send "Examples" "Examples of using the script:\n1. To search for files, select 'Search Files' and enter a query.\n2. To manage WiFi, select 'WiFi Management' and choose an option.\n3. To convert numbers, select 'Number Conversion' and choose an option."
                ;;
            "3. Tutorials")
                notify-send "Tutorials" "Tutorials for using the script:\n1. Navigate through the menu options to explore features.\n2. Use the 'Interactive Tutorial' option for a guided walkthrough."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Error Logging and Debugging
error_logging_and_debugging() {
    while true; do
        choice=$(echo -e "1. View Logs\n2. Clear Logs\n3. Enable Debug Mode\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. View Logs")
                logs=$(cat "$LOG_FILE")
                if [[ -z "$logs" ]]; then
                    notify-send "Logs" "No logs found."
                else
                    notify-send "Logs" "$logs"
                fi
                ;;
            "2. Clear Logs")
                > "$LOG_FILE"
                notify-send "Logs Cleared" "All logs have been cleared."
                ;;
            "3. Enable Debug Mode")
                set -x
                notify-send "Debug Mode" "Debug mode enabled. Check the terminal for detailed output."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Multi-Language Support
multi_language_support() {
    while true; do
        choice=$(echo -e "1. English\n2. Spanish\n3. French\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. English")
                LANGUAGE="en"
                sed -i "s/LANGUAGE=.*/LANGUAGE=\"$LANGUAGE\"/" "$CONFIG_FILE"
                notify-send "Language Changed" "English language applied."
                ;;
            "2. Spanish")
                LANGUAGE="es"
                sed -i "s/LANGUAGE=.*/LANGUAGE=\"$LANGUAGE\"/" "$CONFIG_FILE"
                notify-send "Language Changed" "Spanish language applied."
                ;;
            "3. French")
                LANGUAGE="fr"
                sed -i "s/LANGUAGE=.*/LANGUAGE=\"$LANGUAGE\"/" "$CONFIG_FILE"
                notify-send "Language Changed" "French language applied."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Interactive Tutorial
interactive_tutorial() {
    notify-send "Interactive Tutorial" "Welcome to the interactive tutorial!\n1. Use the menu to navigate through features.\n2. Follow the on-screen instructions.\n3. Press 'Back' to return to the main menu."
    main_menu
}

# Function for System Updates
system_updates() {
    while true; do
        choice=$(echo -e "1. Check for Updates\n2. Install Updates\n3. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 3)
        case "$choice" in
            "1. Check for Updates")
                updates=$(sudo apt-get update && sudo apt-get upgrade -s)
                if [[ -z "$updates" ]]; then
                    notify-send "Updates" "No updates available."
                else
                    notify-send "Updates" "$updates"
                fi
                ;;
            "2. Install Updates")
                sudo apt-get update && sudo apt-get upgrade -y
                notify-send "Updates Installed" "All updates have been installed."
                ;;
            "3. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Function for Community Features
community_features() {
    while true; do
        choice=$(echo -e "1. Submit Feedback\n2. Share Themes\n3. Share Plugins\n4. Back to Main Menu" | rofi -dmenu -i -p "Choose an option" -lines 4)
        case "$choice" in
            "1. Submit Feedback")
                feedback=$(rofi -dmenu -p "Enter your feedback" -lines 1 -width 40)
                if [[ -z "$feedback" ]]; then
                    notify-send "Error" "Feedback cannot be empty."
                    continue
                fi
                echo "$feedback" >> "$HOME/feedback.txt"
                notify-send "Feedback Submitted" "Thank you for your feedback!"
                ;;
            "2. Share Themes")
                notify-send "Share Themes" "Feature under construction."
                ;;
            "3. Share Plugins")
                notify-send "Share Plugins" "Feature under construction."
                ;;
            "4. Back to Main Menu")
                main_menu
                return
                ;;
            *)
                notify-send "Invalid option selected. Returning to menu."
                ;;
        esac
    done
}

# Load configuration and start the main menu
load_config
main_menu
