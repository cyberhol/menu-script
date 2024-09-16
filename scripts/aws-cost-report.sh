#!/bin/bash

# name: AWS Cost Report
# description: Generate AWS cost and usage report

# Default values
start_date=$(date -d "1 month ago" +%Y-%m-%d)
end_date=$(date +%Y-%m-%d)
granularity="MONTHLY"
metric="UsageQuantity"
group_by="SERVICE"
output_format="table"

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -s, --start-date YYYY-MM-DD   Start date (default: 1 month ago)"
    echo "  -e, --end-date YYYY-MM-DD     End date (default: today)"
    echo "  -g, --granularity GRAN        Granularity: DAILY|MONTHLY (default: MONTHLY)"
    echo "  -m, --metric METRIC           Metric to use (default: UsageQuantity)"
    echo "  -b, --group-by KEY            Group by: SERVICE|USAGE_TYPE|etc. (default: SERVICE)"
    echo "  -o, --output FORMAT           Output format: table|json|text (default: table)"
    echo "  -h, --help                    Display this help message"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -s|--start-date)
            start_date="$2"
            shift 2
            ;;
        -e|--end-date)
            end_date="$2"
            shift 2
            ;;
        -g|--granularity)
            granularity="$2"
            shift 2
            ;;
        -m|--metric)
            metric="$2"
            shift 2
            ;;
        -b|--group-by)
            group_by="$2"
            shift 2
            ;;
        -o|--output)
            output_format="$2"
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

# Run the AWS CLI command
aws ce get-cost-and-usage \
    --time-period Start=$start_date,End=$end_date \
    --granularity $granularity \
    --metrics "$metric" \
    --group-by Type=DIMENSION,Key=$group_by \
    --query "ResultsByTime[].Groups[?Metrics.$metric.Amount!='0'].[Keys[0],Metrics.$metric.Amount]" \
    --output $output_format