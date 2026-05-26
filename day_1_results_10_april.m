% =========================================================
% BEHAVIORAL DATA ANALYSIS: WIN-SHIFT TASK (UPDATED V2)
% =========================================================

% Clear workspace and command window
clear; clc;

% --- 0. DATA IMPORT ---
% Allows the user to select the file dynamically
[nome_file_scelto, percorso] = uigetfile('*.xlsx', 'Seleziona il file Excel da analizzare');
if isequal(nome_file_scelto, 0)
    disp('Operazione annullata.');
    return; 
end

fileName = fullfile(percorso, nome_file_scelto); 

% Import options: reading from Row 1 after data cleaning
opts = detectImportOptions(fileName);
opts.DataRange = 'A1'; 
opts.VariableNamingRule = 'preserve';
T = readtable(fileName, opts);

% --- 1. MAZE ARMS SETUP ---
% Define the correct arms for each trial (To be updated per session)
right_arms_trial1 = [1, 3, 6, 7]; 
right_arms_trial2 = [2, 4, 5, 8]; 

% Pre-allocate columns for cognitive and spatial metrics
T.Error_Rank = NaN(height(T), 1);
T.First4_Accuracy = NaN(height(T), 1); 
T.Clockwise_Index = NaN(height(T), 1); 

% --- 2. MAIN PROCESSING LOOP ---
for i = 1:height(T)
    
    % Proceed only if the sequence cell is not empty
    if ~isempty(T.("Arms sequence"){i})
        
        % Trial condition check
        if T.("Trial n")(i) == 1
            arms_to_use = right_arms_trial1;
        elseif T.("Trial n")(i) == 2
            arms_to_use = right_arms_trial2;
        else
            continue; 
        end
        
        % ROBUST DATA EXTRACTION
        % Uses lowercase 'string' function and regex to handle typos in Excel
        sequence_text = string(T.("Arms sequence"){i});
        extracted_numbers = regexp(sequence_text, '\d+', 'match');
        visited_arms = str2double(extracted_numbers); 
        
        is_correct = ismember(visited_arms, arms_to_use);
        
        % --- METRIC 1: ERROR RANK ---
        first_correct_pos = find(is_correct, 1);
        if ~isempty(first_correct_pos)
            T.Error_Rank(i) = first_correct_pos - 1;
        else
            T.Error_Rank(i) = length(visited_arms);
        end

        % --- METRIC 2: FIRST-4 ACCURACY ---
        num_choices = min(4, length(visited_arms));
        if num_choices > 0
            correct_in_first_4 = sum(is_correct(1:num_choices));
            T.First4_Accuracy(i) = correct_in_first_4 / 4; 
        end
        
        % --- METRIC 3: CLOCKWISE INDEX ---
        total_transitions = length(visited_arms) - 1;
        if total_transitions > 0
            clockwise_count = 0;
            for j = 1:total_transitions
                current_arm = visited_arms(j);
                next_arm = visited_arms(j+1);
                
                % Checks for clockwise transition (n -> n+1) or the 8 -> 1 edge case
                if (next_arm == current_arm + 1) || (current_arm == 8 && next_arm == 1)
                    clockwise_count = clockwise_count + 1;
                end
            end
            T.Clockwise_Index(i) = clockwise_count / total_transitions;
        else
            T.Clockwise_Index(i) = NaN; 
        end
       
    end 
end 

% --- 3. DISPLAY AND EXPORT ---
% Display the first 15 rows for a quick sanity check
head(T(:, {'Rat n', 'Trial n', 'Arms sequence', 'Error_Rank', 'First4_Accuracy', 'Clockwise_Index'}), 15)

% Export the final table with the correct extension
nome_salvataggio = 'WinShift_Results_Final.xlsx'; 
writetable(T, nome_salvataggio);
disp(['Processing complete! The file ' nome_salvataggio ' has been successfully saved.']);
