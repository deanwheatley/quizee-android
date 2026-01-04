/*
 * Copyright 2024 Quizee
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.quizee.app.main.twa;

import org.junit.Test;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Random;
import java.util.Set;

import static org.junit.Assert.*;

/**
 * Property-based tests for SplashActivity loading message selection.
 * 
 * **Feature: quizee-loading-rebrand, Property 1: Loading message selection always returns valid message**
 * **Validates: Requirements 2.1**
 */
public class SplashActivityTest {

    private static final String[] TEST_MESSAGES = {
        "Getting your quiz ready…",
        "Loading brain teasers…",
        "Preparing fun questions…",
        "Warming up the quiz engine…",
        "Almost there…",
        "Loading awesome quizzes…",
        "Get ready to test your knowledge!",
        "Shuffling the questions…",
        "Loading your challenge…",
        "Quiz time is coming!"
    };

    /**
     * Property Test: For any random seed, the message selector always returns
     * a message that is a member of the predefined messages array.
     * 
     * **Feature: quizee-loading-rebrand, Property 1: Loading message selection always returns valid message**
     * **Validates: Requirements 2.1**
     */
    @Test
    public void propertyTest_selectRandomMessage_alwaysReturnsValidMessage() {
        Set<String> validMessages = new HashSet<>(Arrays.asList(TEST_MESSAGES));
        
        // Test with 100+ different random seeds
        for (int seed = 0; seed < 150; seed++) {
            Random random = new Random(seed);
            String result = SplashActivity.selectRandomMessage(TEST_MESSAGES, random);
            
            assertTrue(
                "Message '" + result + "' with seed " + seed + " should be in the valid messages set",
                validMessages.contains(result)
            );
        }
    }

    /**
     * Property Test: For any random instance, multiple calls should produce
     * varied results (not always the same message).
     */
    @Test
    public void propertyTest_selectRandomMessage_producesVariedResults() {
        Set<String> selectedMessages = new HashSet<>();
        Random random = new Random();
        
        // Make 100 selections
        for (int i = 0; i < 100; i++) {
            String result = SplashActivity.selectRandomMessage(TEST_MESSAGES, random);
            selectedMessages.add(result);
        }
        
        // Should have selected more than 1 unique message over 100 tries
        assertTrue(
            "Should produce varied results, but only got " + selectedMessages.size() + " unique messages",
            selectedMessages.size() > 1
        );
    }

    /**
     * Edge case: Empty array should return empty string.
     */
    @Test
    public void selectRandomMessage_emptyArray_returnsEmptyString() {
        String result = SplashActivity.selectRandomMessage(new String[]{}, new Random());
        assertEquals("", result);
    }

    /**
     * Edge case: Null array should return empty string.
     */
    @Test
    public void selectRandomMessage_nullArray_returnsEmptyString() {
        String result = SplashActivity.selectRandomMessage(null, new Random());
        assertEquals("", result);
    }

    /**
     * Edge case: Single element array should always return that element.
     */
    @Test
    public void selectRandomMessage_singleElement_alwaysReturnsThatElement() {
        String[] singleMessage = {"Only message"};
        
        for (int i = 0; i < 10; i++) {
            String result = SplashActivity.selectRandomMessage(singleMessage, new Random());
            assertEquals("Only message", result);
        }
    }
}
