const analysisOptionsFile = '''
include: package:flutter_lints/flutter.yaml

analyzer:
  language:
    #   strict-casts: true
    strict-inference: true
    strict-raw-types: true

  exclude:
    - lib/**.config.dart
    - lib/**.freezed.dart
    - lib/**.g.dart

  errors:
    close_sinks: ignore
    missing_required_param: error
    missing_return: error
    record_literal_one_positional_no_trailing_comma: error
    collection_methods_unrelated_type: warning
    unrelated_type_equality_checks: warning



linter:
  rules:
    - always_declare_return_types
    - always_put_required_named_parameters_first
    - always_use_package_imports
    - annotate_overrides
    - avoid_dynamic_calls
    - avoid_empty_else
    - avoid_init_to_null
    - avoid_multiple_declarations_per_line
    - avoid_null_checks_in_equality_operators
    - avoid_print
    - avoid_redundant_argument_values
    - avoid_relative_lib_imports
    - avoid_returning_null_for_void
    - avoid_returning_this
    - avoid_unnecessary_containers
    - avoid_unused_constructor_parameters
    - avoid_void_async
    - avoid_web_libraries_in_flutter
    - await_only_futures
    - camel_case_extensions
    - camel_case_types
    - cancel_subscriptions
    - collection_methods_unrelated_type
    - constant_identifier_names
    - control_flow_in_finally
    - curly_braces_in_flow_control_structures
    - deprecated_consistency
    - directives_ordering
    - exhaustive_cases
    - file_names
    - hash_and_equals
#    - invalid_case_patterns
#    - join_return_with_assignment
#    - leading_newlines_in_multiline_strings
#    - library_annotations
#    - library_names
#    - library_prefixes
#    - library_private_types_in_public_api
#    - lines_longer_than_80_chars
#    - literal_only_boolean_expressions
#    - missing_whitespace_between_adjacent_strings
#    - no_default_cases
#    - no_duplicate_case_values
#    - no_leading_underscores_for_library_prefixes
#    - no_leading_underscores_for_local_identifiers
#    - no_logic_in_create_state
#    - no_runtimeType_toString
#    - non_constant_identifier_names
#    - noop_primitive_operations
#    - null_check_on_nullable_type_parameter
#    - null_closures
#    - omit_local_variable_types
#    - only_throw_errors
#    - overridden_fields
#    - package_api_docs
#    - package_names
#    - package_prefixed_library_names
#    - parameter_assignments
#    - prefer_adjacent_string_concatenation
#    - prefer_asserts_in_initializer_lists
#    - prefer_asserts_with_message
#    - prefer_collection_literals
#    - prefer_conditional_assignment
#    - prefer_const_constructors
#    - prefer_const_constructors_in_immutables
#    - prefer_const_declarations
#    - prefer_const_literals_to_create_immutables
#    - prefer_constructors_over_static_methods
#    - prefer_contains
#    - prefer_final_fields
#    - prefer_final_in_for_each
#    - prefer_final_locals
#    - prefer_for_elements_to_map_fromIterable
#    - prefer_function_declarations_over_variables
#    - prefer_generic_function_type_aliases
#    - prefer_if_elements_to_conditional_expressions
#    - prefer_if_null_operators
#    - prefer_initializing_formals
#    - prefer_inlined_adds
#    - prefer_int_literals
#    - prefer_interpolation_to_compose_strings
#    - prefer_is_empty
#    - prefer_is_not_empty
#    - prefer_is_not_operator
#    - prefer_iterable_whereType
#    - prefer_null_aware_method_calls
#    - prefer_null_aware_operators
#    - prefer_single_quotes
#    - prefer_spread_collections
#    - prefer_typing_uninitialized_variables
#    - prefer_void_to_null
#    - provide_deprecation_message
#    - recursive_getters
#    - require_trailing_commas
#    - secure_pubspec_urls
#    - sized_box_for_whitespace
#    - sized_box_shrink_expand
#    - slash_for_doc_comments
#    - sort_child_properties_last
#    - sort_constructors_first
#    - sort_unnamed_constructors_first
#    - test_types_in_equals
#    - throw_in_finally
#    - tighten_type_of_initializing_formals
#    - type_annotate_public_apis
#    - type_init_formals
#    - unawaited_futures
#    - unnecessary_await_in_return
#    - unnecessary_breaks
#    - unnecessary_brace_in_string_interps
#    - unnecessary_const
#    - unnecessary_constructor_name
#    - unnecessary_getters_setters
#    - unnecessary_lambdas
#    - unnecessary_late
#    - unnecessary_library_directive
#    - unnecessary_new
#    - unnecessary_null_aware_assignments
#    - unnecessary_null_checks
#    - unnecessary_null_in_if_null_operators
#    - unnecessary_nullable_for_final_variable_declarations
#    - unnecessary_overrides
#    - unnecessary_parenthesis
#    - unnecessary_raw_strings
#    - unnecessary_statements
#    - unnecessary_string_escapes
#    - unnecessary_string_interpolations
#    - unnecessary_this
#    - unnecessary_to_list_in_spreads
#    - unrelated_type_equality_checks
#    - use_build_context_synchronously
#    - use_colored_box
#    - use_enums
#    - use_full_hex_values_for_flutter_colors
#    - use_function_type_syntax_for_parameters
#    - use_if_null_to_convert_nulls_to_bools
#    - use_is_even_rather_than_modulo
#    - use_key_in_widget_constructors
#    - use_late_for_private_fields_and_variables
#    - use_named_constants
#    - use_raw_strings
#    - use_rethrow_when_possible
#    - use_setters_to_change_properties
#    - use_string_buffers
#    - use_string_in_part_of_directives
#    - use_super_parameters
#    - use_test_throws_matchers
#    - use_to_and_as_if_applicable
#    - valid_regexps
#    - void_checks
''';