package com.lingua.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import java.util.*;

@Controller
public class PuzzleController {

    @GetMapping("/puzzles/word-scramble")
    public String wordScramble(Model model) {
        // Generate a random word to scramble
        String[] words = {"HELLO", "WORLD", "LEARN", "STUDY", "ENGLISH", "PUZZLE", "GAME", "WORD", "LETTER", "BRAIN"};
        String originalWord = words[new Random().nextInt(words.length)];
        String scrambledWord = scrambleWord(originalWord);
        
        model.addAttribute("scrambledWord", scrambledWord);
        model.addAttribute("originalWord", originalWord);
        model.addAttribute("wordLength", originalWord.length());
        
        return "puzzle-word-scramble";
    }
    
    @PostMapping("/puzzles/word-scramble/check")
    public String checkWordScramble(@RequestParam String userAnswer, @RequestParam String originalWord, Model model) {
        boolean isCorrect = userAnswer.toUpperCase().equals(originalWord.toUpperCase());
        
        model.addAttribute("isCorrect", isCorrect);
        model.addAttribute("userAnswer", userAnswer);
        model.addAttribute("correctAnswer", originalWord);
        
        if (isCorrect) {
            // Generate new word for next round
            String[] words = {"HELLO", "WORLD", "LEARN", "STUDY", "ENGLISH", "PUZZLE", "GAME", "WORD", "LETTER", "BRAIN"};
            String newWord = words[new Random().nextInt(words.length)];
            String newScrambled = scrambleWord(newWord);
            
            model.addAttribute("scrambledWord", newScrambled);
            model.addAttribute("originalWord", newWord);
            model.addAttribute("wordLength", newWord.length());
        }
        
        return "puzzle-word-scramble";
    }

    @GetMapping("/puzzles/word-search")
    public String wordSearch(Model model) {
        // Create a simple word search grid
        char[][] grid = generateWordSearchGrid();
        String[] wordsToFind = {"CAT", "DOG", "SUN", "RUN", "FUN"};
        
        model.addAttribute("grid", grid);
        model.addAttribute("wordsToFind", wordsToFind);
        model.addAttribute("gridSize", 8);
        
        return "puzzle-word-search";
    }

    @GetMapping("/puzzles/crossword")
    public String crossword(Model model) {
        // Simple crossword data
        Map<String, Object> crosswordData = new HashMap<>();
        crosswordData.put("clues", Arrays.asList(
            "1 Across: Opposite of night (3 letters)",
            "2 Down: Animal that barks (3 letters)",
            "3 Across: Color of grass (5 letters)"
        ));
        
        model.addAttribute("crosswordData", crosswordData);
        return "puzzle-crossword";
    }

    @GetMapping("/puzzles/anagrams")
    public String anagrams(Model model) {
        String[] words = {"LISTEN", "SILENT", "EARTH", "HEART", "ANGEL", "GLEAN"};
        String word = words[new Random().nextInt(words.length)];
        
        model.addAttribute("word", word);
        model.addAttribute("letters", word.toCharArray());
        
        return "puzzle-anagrams";
    }

    @GetMapping("/puzzles/riddles")
    public String riddles(Model model) {
        String[] riddles = {
            "What has keys but no locks, space but no room?",
            "What gets wet while drying?",
            "What has hands but cannot clap?"
        };
        String[] answers = {"KEYBOARD", "TOWEL", "CLOCK"};
        
        int index = new Random().nextInt(riddles.length);
        
        model.addAttribute("riddle", riddles[index]);
        model.addAttribute("answer", answers[index]);
        
        return "puzzle-riddles";
    }

    // Helper method to scramble words
    private String scrambleWord(String word) {
        List<Character> letters = new ArrayList<>();
        for (char c : word.toCharArray()) {
            letters.add(c);
        }
        Collections.shuffle(letters);
        
        StringBuilder scrambled = new StringBuilder();
        for (char c : letters) {
            scrambled.append(c);
        }
        
        return scrambled.toString();
    }

    // Helper method to generate word search grid
    private char[][] generateWordSearchGrid() {
        char[][] grid = new char[8][8];
        Random random = new Random();
        
        // Fill with random letters
        for (int i = 0; i < 8; i++) {
            for (int j = 0; j < 8; j++) {
                grid[i][j] = (char) ('A' + random.nextInt(26));
            }
        }
        
        // Place some words
        String[] words = {"CAT", "DOG", "SUN", "RUN", "FUN"};
        for (String word : words) {
            placeWordInGrid(grid, word, random);
        }
        
        return grid;
    }

    private void placeWordInGrid(char[][] grid, String word, Random random) {
        boolean placed = false;
        int attempts = 0;
        
        while (!placed && attempts < 50) {
            int row = random.nextInt(8);
            int col = random.nextInt(8);
            int direction = random.nextInt(2); // 0 = horizontal, 1 = vertical
            
            if (canPlaceWord(grid, word, row, col, direction)) {
                for (int i = 0; i < word.length(); i++) {
                    if (direction == 0) {
                        grid[row][col + i] = word.charAt(i);
                    } else {
                        grid[row + i][col] = word.charAt(i);
                    }
                }
                placed = true;
            }
            attempts++;
        }
    }

    private boolean canPlaceWord(char[][] grid, String word, int row, int col, int direction) {
        if (direction == 0) { // horizontal
            return col + word.length() <= 8;
        } else { // vertical
            return row + word.length() <= 8;
        }
    }
}
