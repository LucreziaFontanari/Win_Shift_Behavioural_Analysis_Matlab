% ==========================================
% BEHAVIORAL DATA ANALYSIS: WIN-SHIFT TASK
% ==========================================

% --- 0. DATA IMPORT ---
% Update the file name here when analyzing a new day
fileName = '10.4.xlsx'; 

% Setup import options to read from row 8 and keep original headers
opts = detectImportOptions(fileName);
opts.DataRange = 'A8';
opts.VariableNamingRule = 'preserve';
T = readtable(fileName, opts);

% --- 1. MAZE ARMS SETUP ---
% Define the correct arms for each trial
right_arms_trial1 = [1, 3, 6, 7]; 
right_arms_trial2 = [2, 4, 5, 8]; 

% Pre-allocate new columns for the metrics
T.Error_Rank = NaN(height(T), 1);
T.Total_Score = NaN(height(T), 1); 

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
        first_correct_pos = find(is_correct, 1);
        if ~isempty(first_correct_pos)
            T.Error_Rank(i) = first_correct_pos - 1;
        else
            T.Error_Rank(i) = length(visited_arms);
        end
        
        % --- TOTAL SCORE CALCULATION ---
        n_correct = sum(is_correct);      
        n_incorrect = sum(~is_correct);   
        
        if (n_correct + n_incorrect) > 0
            T.Total_Score(i) = (n_correct - n_incorrect) / (n_correct + n_incorrect);
        end
    end
end

% --- 3. DISPLAY AND EXPORT ---
% Display the first 15 rows in the Command Window
head(T(:, {'Rat n', 'Trial n', 'Arms sequence', 'Error_Rank', 'Total_Score'}), 15)

% Export the final processed table
writetable(T, 'day 1 final results.xlsx');
disp('Processing complete! The updated Excel file has been saved.');