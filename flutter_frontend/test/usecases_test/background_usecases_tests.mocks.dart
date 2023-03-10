// Mocks generated by Mockito 5.3.2 from annotations
// in flutter_frontend/test/usecases_test/background_usecases_tests.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_frontend/data/datasources/nodejs_datasource.dart'
    as _i3;
import 'package:flutter_frontend/data/models/background.dart' as _i5;
import 'package:flutter_frontend/data/models/operation_result.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResult_0 extends _i1.SmartFake implements _i2.Result {
  _FakeResult_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NodeJSDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNodeJSDatasource extends _i1.Mock implements _i3.NodeJSDatasource {
  MockNodeJSDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Result> sendAndGenerate(
          {required _i5.Background? background}) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendAndGenerate,
          [],
          {#background: background},
        ),
        returnValue: _i4.Future<_i2.Result>.value(_FakeResult_0(
          this,
          Invocation.method(
            #sendAndGenerate,
            [],
            {#background: background},
          ),
        )),
      ) as _i4.Future<_i2.Result>);
}
