# SUnit-Parametrized

*SUnit-Parametrized* is an extension of SUnit that allows to parametrize
tests. Multiple parameters can be specified (both at test or testcase level)
and test are run for every combination.

This extensions has been implemented so:

  * Existing tests work with parametrized tests, allowing
    one to incrementally moved from "standard" tests to
    parametrized tests.
  * Testcases may extend/modify the behavior (the way parameters
    are combined, kind of parameters and so on).
  * Parametrized tests work with existing tools¹ - test runners,
    browsers...
  * Be portable, at the very least to work on Pharo 8 and Smalltalk/X.

## Usage

To create a parametrized test, simply subclass `TestCaseParametrized` and
define test:

```
testWithParameter
	<parameter: #val values: #(1 2 3)>

	self assert: ((testParameters at:#val) between: 1 and: 3)
```

For more examples, see class [ParametrizedTestExamples](src/SUnit-Parametrized/ParametrizedTestExamples.class.st)

## Loading

```
"In Pharo 8"

Metacello new
	baseline: 'SUnitParametrized';
	repository: 'github://janvrany/pharo-hacks';
	load.

"In Smalltalk/X"

Smalltalk loadPackage: 'stx:goodies/sunit/ext/parametrized'.
```

## License

 Code is released under MIT license, see [LICENSE](LICENSE)

--

(¹) The problem here is that many (all) of existing tools simply
    assume a class and selector makes a test - which is not true
    for paramerized tests. However existing tools should not "crash"
    when running parametrized test, whether they provide useful UI
    is a different story.