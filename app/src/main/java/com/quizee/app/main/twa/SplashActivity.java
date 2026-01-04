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

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.widget.TextView;

import java.util.Random;

/**
 * Custom splash screen activity that displays a random loading message
 * before launching the main TWA LauncherActivity.
 */
public class SplashActivity extends Activity {

    private static final int SPLASH_DELAY_MS = 1500;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_splash);

        // Display random loading message
        TextView loadingMessageView = findViewById(R.id.loading_message);
        String message = getRandomLoadingMessage();
        loadingMessageView.setText(message);

        // Delay then launch the main activity
        new Handler(Looper.getMainLooper()).postDelayed(() -> {
            Intent intent = new Intent(SplashActivity.this, LauncherActivity.class);
            startActivity(intent);
            finish();
        }, SPLASH_DELAY_MS);
    }

    /**
     * Selects a random loading message from the predefined array.
     * @return A randomly selected loading message string
     */
    public String getRandomLoadingMessage() {
        String[] messages = getResources().getStringArray(R.array.loading_messages);
        return selectRandomMessage(messages, new Random());
    }

    /**
     * Selects a random message from the given array using the provided Random instance.
     * This method is package-private to allow testing.
     * @param messages Array of messages to select from
     * @param random Random instance for selection
     * @return A randomly selected message, or empty string if array is empty
     */
    static String selectRandomMessage(String[] messages, Random random) {
        if (messages == null || messages.length == 0) {
            return "";
        }
        int index = random.nextInt(messages.length);
        return messages[index];
    }
}
