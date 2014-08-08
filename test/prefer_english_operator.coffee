path = require 'path'
vows = require 'vows'
assert = require 'assert'
coffeelint = require path.join('..', 'lib', 'coffeelint')

configError = {prefer_english_operator: {level: 'error'}}

vows.describe('PreferEnglishOperatorssemicolons').addBatch({

    'non-English operators':
        'should warn when == is used': ->
            result = coffeelint.lint('1 == 1', configError)[0]
            assert.equal result.context, 'Found: =='

        'should warn when != is used': ->
            result = coffeelint.lint('1 != 1', configError)[0]
            assert.equal result.context, 'Found: !='

        'should warn when && is used': ->
            result = coffeelint.lint('1 && 1', configError)[0]
            assert.equal result.context, 'Found: &&'

        'should warn when || is used': ->
            result = coffeelint.lint('1 || 1', configError)[0]
            assert.equal result.context, 'Found: ||'

    'English operators':
        'should not warn when \'is\' is used': ->
            assert.isEmpty(coffeelint.lint('1 is 1', configError).length)

        'should not warn when \'isnt\' is used': ->
            assert.isEmpty(coffeelint.lint('1 isnt 1', configError).length)

        'should not warn when \'and\' is used': ->
            assert.isEmpty(coffeelint.lint('1 and 1', configError).length)

        'should not warn when \'or\' is used': ->
            assert.isEmpty(coffeelint.lint('1 or 1', configError).length)

    'Comments': ->
        topic: """
        # 1 == 1
        # 1 != 1
        # 1 && 1
        # 1 || 1
        ###
        1 == 1
        1 != 1
        1 && 1
        1 || 1
        ###
        """
        'should not warn when == is used in a comment': (source) ->
            assert.isEmpty(coffeelint.lint(source, configError).length)

    'Strings':
        'should not warn when == is used in a single-quote string': ->
            assert.isEmpty(coffeelint.lint('\'1 == 1\'', configError).length)

        'should not warn when == is used in a double-quote string': ->
            assert.isEmpty(coffeelint.lint('"1 == 1"', configError).length)

        'should not warn when == is used in a multiline string': ->
            source = '''
                """
                1 == 1
                """
            '''
            assert.isEmpty(coffeelint.lint(source, configError).length)

}).export(module)




