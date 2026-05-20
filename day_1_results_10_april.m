% ==========================================
% BEHAVIORAL DATA ANALYSIS: WIN-SHIFT TASK
% ==========================================

% Clear workspace to prevent data mixing across different sessions
clear; clc;

% --- 0. DATA IMPORT ---
fileName = '10.4.xlsx'; 

% Setup import options (auto-detects data range to avoid NaN errors)
opts = detectImportOptions(fileName);
opts.VariableNamingRule = 'preserve';
T = readtable(fileName, opts);

% --- 1. MAZE ARMS SETUP ---
% Define the correct arms for each trial (Update daily)
right_arms_trial1 = [1, 3, 6, 7]; 
right_arms_trial2 = [2, 4, 5, 8]; 

% Pre-allocate new columns for the metrics
T.Error_Rank = NaN(height(T), 1);
T.First4_Accuracy = NaN(height(T), 1); 

% --- 2. MAIN PROCESSING LOOP ---
for i = 1:height(T)
    
    % Check if the cell containing the sequence is not empty
    if ~isempty(T.("Arms sequence"){i})
        
        % Select the appropriate correct arms based on the trial number
        if T.("Trial n")(i) == 1
            arms_to_use = right_arms_trial1;
        elseif T.("Trial n")(i) == 2
            arms_to_use = right_arms_trial2;
        else
            continue; 
        end
        
        % ROBUST DATA EXTRACTION: Extract only numeric digits
        sequence_text = string(T.("Arms sequence"){i});
        extracted_numbers = regexp(sequence_text, '\d+', 'match');
        visited_arms = str2double(extracted_numbers); 
        
        % Evaluate the rat's choices against the correct arms
        is_correct = ismember(visited_arms, arms_to_use);
        
        % --- ERROR RANK CALCULATION ---
        % Number of errors before the first correct choice
        first_correct_pos = find(is_correct, 1);
        if ~isempty(first_correct_pos)
            T.Error_Rank(i) = first_correct_pos - 1;
        else
            T.Error_Rank(i) = length(visited_arms);
        end

        % --- FIRST-4 ACCURACY CALCULATION ---
        % Ratio of correct choices within the first 4 maze entries
        num_choices = min(4, length(visited_arms));
        if num_choices > 0
            correct_in_first_4 = sum(is_correct(1:num_choices));
            T.First4_Accuracy(i) = correct_in_first_4 / 4; 
        end
       
    end 
end 

% --- 3. DISPLAY AND EXPORT ---
% Display the first 15 rows in the Command Window
head(T(:, {'Rat n', 'Trial n', 'Arms sequence', 'Error_Rank', 'First4_Accuracy'}), 15)

% Export the final processed table
writetable(T, 'DayX_Final_Results.xlsx');
disp('Processing complete! The updated Excel file has been saved.');
