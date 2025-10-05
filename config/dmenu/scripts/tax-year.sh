#!/usr/bin/env bash

case "$(echo -e "2025\n2024\n2023" | dmenu -i)" in
    2025) libreoffice ~/Documents/01-Work/01-Finances/2025-TaxReport.ods ;;
    2024) libreoffice ~/Documents/01-Work/01-Finances/2024-TaxReport.xlsx ;;
    2023) libreoffice ~/Documents/01-Work/01-Finances/2023-TaxReport.xlsx ;;
esac
