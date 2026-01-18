#!/bin/bash
# feishu-playbook utility script
# Helper functions for project management

set -e

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print colored message
print_msg() {
    local color=$1
    local msg=$2
    echo -e "${color}${msg}${NC}"
}

# Create new skill
create_skill() {
    local skill_name=$1

    if [ -z "$skill_name" ]; then
        print_msg "$RED" "Error: Skill name is required"
        echo "Usage: $0 create-skill <skill-name>"
        exit 1
    fi

    print_msg "$GREEN" "Creating skill: $skill_name"

    # Create skill directory
    mkdir -p "skills/$skill_name"

    # Create skill files
    touch "skills/$skill_name/skill.md"
    touch "skills/$skill_name/examples.md"
    touch "skills/$skill_name/best-practices.md"

    print_msg "$GREEN" "✓ Skill structure created"
    print_msg "$YELLOW" "Next steps:"
    echo "  1. Edit skills/$skill_name/skill.md"
    echo "  2. Add examples to skills/$skill_name/examples.md"
    echo "  3. Document best practices in skills/$skill_name/best-practices.md"
}

# Create workflow script
create_workflow() {
    local workflow_name=$1

    if [ -z "$workflow_name" ]; then
        print_msg "$RED" "Error: Workflow name is required"
        echo "Usage: $0 create-workflow <workflow-name>"
        exit 1
    fi

    print_msg "$GREEN" "Creating workflow: $workflow_name"

    # Create workflow file
    local script_file="workflows/${workflow_name}.sh"

    cat > "$script_file" << 'EOF'
#!/bin/bash
set -e

# Parameters
if [ -z "$1" ]; then
    echo "Usage: $0 <param>"
    exit 1
fi

# Main logic
echo "Executing workflow..."

# Error handling
if [ $? -ne 0 ]; then
    echo "Error: workflow failed"
    exit 1
fi

echo "Workflow completed successfully"
EOF

    # Add execute permission
    chmod +x "$script_file"

    print_msg "$GREEN" "✓ Workflow script created: $script_file"
    print_msg "$YELLOW" "Next: Edit the script to implement your workflow logic"
}

# Validate project
validate_project() {
    print_msg "$GREEN" "Validating feishu-playbook project..."

    local errors=0

    # Check README
    if [ ! -f "README.md" ]; then
        print_msg "$RED" "✗ README.md not found"
        ((errors++))
    else
        print_msg "$GREEN" "✓ README.md exists"
    fi

    # Check Skills
    local skill_count=$(find skills/ -name "skill.md" 2>/dev/null | wc -l)
    print_msg "$GREEN" "✓ Found $skill_count skill(s)"

    # Check workflows
    local workflow_count=$(find workflows/ -name "*.sh" 2>/dev/null | wc -l)
    print_msg "$GREEN" "✓ Found $workflow_count workflow(s)"

    # Check documentation
    if [ -d "docs" ]; then
        print_msg "$GREEN" "✓ Documentation directory exists"
    fi

    if [ $errors -eq 0 ]; then
        print_msg "$GREEN" "✓ Project validation passed"
        return 0
    else
        print_msg "$RED" "✗ Project validation failed with $errors error(s)"
        return 1
    fi
}

# Show help
show_help() {
    cat << EOF
feishu-playbook Utility Script

Usage:
    $0 <command> [arguments]

Commands:
    create-skill <name>       Create a new skill structure
    create-workflow <name>    Create a new workflow script
    validate                 Validate project structure
    help                     Show this help message

Examples:
    $0 create-skill feishu-upload
    $0 create-workflow migrate-docs
    $0 validate

For more information, see README.md
EOF
}

# Main
case "${1:-}" in
    create-skill)
        create_skill "$2"
        ;;
    create-workflow)
        create_workflow "$2"
        ;;
    validate)
        validate_project
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_msg "$RED" "Error: Unknown command '$1'"
        show_help
        exit 1
        ;;
esac
