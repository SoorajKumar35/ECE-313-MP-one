%   FILL IN / MODIFY THE CODE WITH "" or comments with !!

% import monitor_alarms.mat and put it in a 
load('monitor_alarms.mat');
data = MonitorAlarms;
% not that the data is in a table format,
% try the following in the command window:
%   data
%   data(1)
%   data.StartTime
%   data.StartTime(1)
% now you have learned how to access data in the table

% remove single quotes from the time data
data.StartTime = strrep(data.StartTime, '''', ''); 
data.StopTime = strrep(data.StopTime, '''', '');

% open the result file
% !! replace # with your own groupID
fid = fopen('ssinha10.txt', 'w');

% T1.1
% !! subset your data for each alarm_type
data_SYSTEM = data(ismember(data.Alarm_Type, 'SYSTEM'), :);
data_ADVISORY = data(ismember(data.Alarm_Type, 'ADVISORY'), :);
data_WARNING = data(ismember(data.Alarm_Type, 'WARNING'), :);
data_CRISIS = data(ismember(data.Alarm_Type, 'CRISIS'), :);


% !! count the number of alarms for each alarm_type
numSYSTEM = height(data_SYSTEM);
numADVISORY = height(data_ADVISORY);
numWARNING = height(data_WARNING);
numCRISIS = height(data_CRISIS);
numALL = height(data);
% !! calaculate the probability for each alarm_type

%fprintf(fid, 'Task 1.1 1\n\n');
%fprintf(fid, 'P(SYSTEM) = %f\n',  numSYSTEM/numALL);
%fprintf(fid, 'P(ADVISORY) = %f\n', numADVISORY/numALL);
%fprintf(fid, 'P(WARNING) = %f\n', numWARNING/numALL);
%fprintf(fid, 'P(CRISIS) = %f\n',  numCRISIS/numALL);

data_APP_ERR = data(ismember(data.Cause, 'APP_ERR'), :);
data_ATR_FIB = data(ismember(data.Cause, 'ATR_FIB'), :);
data_COUPLET = data(ismember(data.Cause, 'COUPLET'), :);
data_HA_BRADY = data(ismember(data.Cause, 'HA_BRADY'), :);
data_LEADS_FAILURE = data(ismember(data.Cause, 'LEADS_FAILURE'), :);
data_LOW_OXY_SAT = data(ismember(data.Cause, 'LOW_OXY_SAT'), :);
data_NW_ERR = data(ismember(data.Cause, 'NW_ERR'), :);
data_PAUSE = data(ismember(data.Cause, 'PAUSE'), :);
data_SIG_ARTIFACT = data(ismember(data.Cause, 'SIG_ARTIFACT'), :);
data_SLEEP_DISORDER = data(ismember(data.Cause, 'SLEEP_DISORDER'), :);

numAPP_ERR = height(data_APP_ERR);
numATR_FIB = height(data_ATR_FIB);
numCOUPLET = height(data_COUPLET);
numHA_BRADY = height(data_HA_BRADY);
numLEADS_FAILURE = height(data_LEADS_FAILURE);
numLOW_OXY_SAT = height(data_LOW_OXY_SAT);
numNW_ERR = height(data_NW_ERR);
numPAUSE = height(data_PAUSE);
numSIG_ARTIFACT = height(data_SIG_ARTIFACT);
numSLEEP_DISORDER = height(data_SLEEP_DISORDER);

disp(sprintf('P(LOW_OXY_SAT) = %f', numLOW_OXY_SAT/numALL));
disp(sprintf('P(APP_ERR) = %f', numAPP_ERR/numALL));
disp(sprintf('P(NW_ERR) = %f', numNW_ERR/numALL));



%T1.2. 
distinctBeds = unique(data.Bed_No);
[x, numBeds] = size(distinctBeds);
numBeds = size(distinctBeds);
for i=1:numBeds,  
%     % !! subset your data for the patient bed
%     % !! do the counts to derive your answers
data_bed_SYSTEM = data(and(ismember(data.Bed_No, distinctBeds(i)), ismember(data.Alarm_Type, 'SYSTEM')), :);
data_bed_ADVISORY = data(and(ismember(data.Bed_No, distinctBeds(i)), ismember(data.Alarm_Type, 'ADVISORY')), :);
data_bed_WARNING = data(and(ismember(data.Bed_No, distinctBeds(i)), ismember(data.Alarm_Type, 'WARNING')), :);
data_bed_CRISIS = data(and(ismember(data.Bed_No, distinctBeds(i)), ismember(data.Alarm_Type, 'CRISIS')), :);
fprintf('P(%f AND SYSTEM) = %f \n', distinctBeds(i), height(data_bed_SYSTEM)/numALL);
fprintf('P(%f AND ADVISORY) = %f \n', distinctBeds(i), height(data_bed_ADVISORY)/numALL);
fprintf('P(%f AND WARNING) = %f \n', distinctBeds(i), height(data_bed_WARNING)/numALL);
fprintf('P(%f AND CRISIS) = %f \n', distinctBeds(i), height(data_bed_CRISIS)/numALL);
end



%T1.3.

%!! Split the data in terms of hours of the start time
%Please note that the time format is 'HH:MM:SS.FFF'
%fprintf(fid, '\n\nTask 1.3\n\n');

data.starthour = str2num(datestr(data.StartTime, 'HH'));

%Print the result
%fprintf(fid, '\t\t0\t1\t2\t3\t4\t5\t6\t7\t8\t9\t10\t11\t12\t13\t14\t15\t16\t17\t18\t19\t20\t21\t22\t23\n');
%fprintf(fid, 'count\t');
array = zeros(1,24);
for i=1:24,
    hour = data(ismember(data.starthour, i), :);
    %!! Count the number of alarms for the given hour(i)
    array(2, i+2) = height(hour);
    %fprintf(fid, '%d\t', 'COUNT_RESULT');
end
% figure;
% 
% hist(data.starthour, 24);
% 
% 
% 
% 
% title('Histogram of Alarms per hour');
% hours = {'00h', '01h', '02h','03h','04h','05h','06h','07h','08h','09h','10h','11h','12h','13h','14h','15h','16h','17h','18h','19h','20h','21h','22h','23h'};
% set(gca, 'XTick', 0:23);
% set(gca,'XTickLabel',hours);
% ylabel('number of alarms');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% T2.1 

causeSYSTEM = {'APP_ERR', 'SIG_ARTIFACT', 'LEADS_FAILURE', 'NW_ERR'};
%fprintf(fid, '\n\nTask 2.1\n\n');
%fprintf(fid, 'Probability of causes for SYSTEM alarms\n');
for i=1:4,
    % !! subset your data
    % !! do the counts to derive your answers
    nSYSTEMas = data(and(ismember( data.Cause,causeSYSTEM(i) ), ismember( data.Alarm_Type, 'SYSTEM') ), :);
    nADVISORYs = data(and(ismember( data.Cause,causeSYSTEM(i) ), ismember( data.Alarm_Type, 'ADVISORY') ), :);
    nWARNINGas = data(and(ismember( data.Cause,causeSYSTEM(i) ), ismember( data.Alarm_Type, 'WARNING') ), :);
    nCRISISas = data(and(ismember( data.Cause,causeSYSTEM(i) ), ismember( data.Alarm_Type, 'CRISIS') ), :);
    %disp(sprintf('P(%s and SYSTEM) = %f',cell2mat(causeSYSTEM(i)), height(nSYSTEMas)/numALL ));
    cause_and_system_p = height(nSYSTEMas)/numALL;
    system_prob = numSYSTEM/numALL;
    disp(sprintf('P(%s|SYSTEM) = %f', cell2mat(causeSYSTEM(i)), cause_and_system_p/system_prob ));
    %fprintf(fid, 'P(%s and SYSTEM) = %f\n', cell2mat(causeSYSTEM(i)), nSYSTEMSas/numALL);
    %fprintf(fid, 'P(%s and ADVISORY) = %f\n', cell2mat(causeSYSTEM(i)), nADVISORYas/numALL);
    %fprintf(fid, 'P(%s and WARNING) = %f\n', cell2mat(causeSYSTEM(i)), nWARNINGas/numALL);
    %fprintf(fid, 'P(%s and SYSTEM) = %f\n', cell2mat(causeSYSTEM(i)), nCRISISas/numALL);
     

    
        
end

APP_ERR_p = height(data(ismember(data.Cause, 'APP_ERR'), :))/numALL;
system_and_APP_ERR_p = height(data(and(ismember(data.Cause, 'APP_ERR'), ismember( data.Alarm_Type, 'SYSTEM') ), :))/numALL;
system_p = numSYSTEM/numALL;
disp(sprintf('P(APP_ERR) = %f', APP_ERR_p));
disp(sprintf('P(system_and_APP_ERR) = %f', system_and_APP_ERR_p));
disp(sprintf('P(APP_ERR|SYSTEM) = %f', system_and_APP_ERR_p/system_p));
disp(sprintf('P(SYSTEM|APP_ERR) = %f', system_and_APP_ERR_p/APP_ERR_p));


% T2.2

% !! Using the results from Task 2.1, derive the probability
system_and_APP_ERR_n = (system_and_APP_ERR_p)*numALL;
disp(sprintf('P(SYSTEM|APP_ERR) = %f', system_and_APP_ERR_p/APP_ERR_p));
disp(sprintf('P(APP_ERR) = %f', APP_ERR_p));
disp(sprintf('P(SYSTEM AND APP_ERR) = %f', APP_ERR_p * (system_and_APP_ERR_p/APP_ERR_p)));
%fprintf(fid, '\n\nTask 2.1\n\n');
nlSYSTEMas = data(and(ismember( data.Cause, 'LOW_OXY_SAT'), ismember( data.Alarm_Type, 'SYSTEM') ), :);
nlADVISORYas = data(and(ismember( data.Cause, 'LOW_OXY_SAT'), ismember( data.Alarm_Type, 'ADVISORY') ), :);
nlWARNINGas = data(and(ismember( data.Cause, 'LOW_OXY_SAT'), ismember( data.Alarm_Type, 'WARNING') ), :);
nlCRISISas = data(and(ismember( data.Cause, 'LOW_OXY_SAT'), ismember( data.Alarm_Type, 'CRISIS') ), :);

%fprintf(fid, 'P(LOW_OXY_SAT and SYSTEM) = %f\n',n1SYSTEMSas/total);
%fprintf(fid, 'P(LOW_OXY_SAT and SYSTEM) = %f\n',n1ADVISORYas/total);
%fprintf(fid, 'P(LOW_OXY_SAT and SYSTEM) = %f\n',n1WARNINGas/total);
%fprintf(fid, 'P(LOW_OXY_SAT and SYSTEM) = %f\n',n1CRISISas/total);



% % % T2.1 
% % 
% % causeSYSTEM = {'APP_ERR', 'SIG_ARTIFACT', 'LEADS_FAILURE', 'NW_ERR'};
% % 
% % 
% % 
% % 
% % 
% % %fprintf(fid, '\n\nTask 2.1\n\n');
% % %fprintf(fid, 'Probability of causes for SYSTEM alarms\n');
% % 
% % % for i=1:4,
% % %    % !! subset your data
% % %    % !! do the counts to derive your answers
% % %    fprintf(fid, 'P(%s) = %f\n', cell2mat(causeSYSTEM(i)), "PROBABILITY FOR CAUSE(i) and SYSTEM");
% % % end
% 
% 
% % 
% % % T2.2
% % 
% % % !! Using the results from Task 2.1, derive the probability
% % 
% % fprintf(fid, '\n\nTask 2.1\n\n');
% % fprintf(fid, 'P(LOW_OXY_SAT and SYSTEM) = %f\n', "PROBABILITY OF LOW_OXY_SAT and SYSTEM");
% % 
% % % T2.3
% % 
% % !! Calculate the duration for each alarms
% % make sure that the durations are in seconds
alarms = {'SYSTEM', 'ADVISORY', 'WARNING', 'CRISIS'};
startTime = datevec(data.StartTime, 'HH:MM:SS.FFF');
endTime = datevec(data.StopTime, 'HH:MM:SS.FFF');
duration = etime(endTime, startTime);
duration_table = array2table(duration);
data = [data duration_table];
data.TimeElapsed = duration;
% 
% % T2.3.a 
% 
%fprintf(fid, '\n\nTask 2.3.a\n\n');
for i=1:4,
%     % !! Split the data interms of alarm type
   alarmData = data(ismember(data.Alarm_Type, alarms(i)), :);
%     % !! Count the number of alarms for each alarm type
   avgTime = mean(alarmData.TimeElapsed,1);  
%     % !! Calculate the average duration of each alarm type
   %fprintf(fid, 'Average duration for alarm type %s: %f\n', cell2mat(alarms(i)), avgTime);
end
% % 
% % T2.3.b
% 
%fprintf(fid, '\n\nTask 2.3.b\n\n');
hourData = datevec(data.StartTime, 'HH:MM:SS.FFF');
hourData = array2table(hourData);
for i=1:24,
%     % Please not that i loop from 1 to 24
%     % The hours in the data are from 0 to 23 
   loops = find(ismember(hourData.hourData4, i-1));
%     % !! Split the data in terms of hours
   set = data(loops,:);  
%     % !! Calculate the average duration for each hour(i)
   avg = mean(set.TimeElapsed, 1);
   theTime(i) = avg;
   %fprintf(fid, 'Average duration for hh=%d = %f\n', i-1, avg);
end
% figure;
% % % !! Draw a bar chart to plot the average duration per hour
% bar(theTime); 
% % % label the plot
% title('Average Duration for each hour of the day');
% ylabel('avg duration');
% hours = {'00h', '01h', '02h','03h','04h','05h','06h','07h','08h','09h','10h','11h','12h','13h','14h','15h','16h','17h','18h','19h','20h','21h','22h','23h'};
% set(gca, 'XTick', 0:23);
% set(gca,'XTickLabel', hours);




% % T3.
% fprintf(fid, '\n\nTask3\n\n');
% % !! Define the metric that identifies patients in a severe situation
% 
% % !! Using your metric, find the top two patient beds in a severe situation
% 
% % !! Extract (split) the data of your interest
% 
% % !! Write your own code for analysis (ref. codes for Task1 and Task2)
% 

% 

% CRISIS = 4
% WARNING = 3
% ADVISORY = 2
% SYSTEM = 1

data_921 = data(ismember(data.Bed_No, 921), :);
data_923 = data(ismember(data.Bed_No, 923), :);
data_940 = data(ismember(data.Bed_No, 940), :);
data_942 = data(ismember(data.Bed_No, 942), :);
data_943 = data(ismember(data.Bed_No, 943), :);
data_944 = data(ismember(data.Bed_No, 944), :);
data_946 = data(ismember(data.Bed_No, 946), :);
data_947 = data(ismember(data.Bed_No, 947), :);
data_952 = data(ismember(data.Bed_No, 952), :);
data_953 = data(ismember(data.Bed_No, 953), :);
data_955 = data(ismember(data.Bed_No, 955), :);
data_956 = data(ismember(data.Bed_No, 956), :);

data_921_CRISIS = data_921(ismember(data_921.Alarm_Type, 'CRISIS'), :);
data_921_WARNING = data_921(ismember(data_921.Alarm_Type, 'WARNING'), :);
data_921_ADVISORY = data_921(ismember(data_921.Alarm_Type, 'ADVISORY'), :);
data_921_SYSTEM = data_921(ismember(data_921.Alarm_Type, 'SYSTEM'), :);

numdata_921_CRISIS = height(data_921_CRISIS);
numdata_921_WARNING = height(data_921_WARNING);
numdata_921_ADVISORY = height(data_921_ADVISORY);
numdata_921_SYSTEM = height(data_921_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_923_CRISIS = data_923(ismember(data_923.Alarm_Type, 'CRISIS'), :);
data_923_WARNING = data_923(ismember(data_923.Alarm_Type, 'WARNING'), :);
data_923_ADVISORY = data_923(ismember(data_923.Alarm_Type, 'ADVISORY'), :);
data_923_SYSTEM = data_923(ismember(data_923.Alarm_Type, 'SYSTEM'), :);

numdata_923_CRISIS = height(data_923_CRISIS);
numdata_923_WARNING = height(data_923_WARNING);
numdata_923_ADVISORY = height(data_923_ADVISORY);
numdata_923_SYSTEM = height(data_923_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_940_CRISIS = data_940(ismember(data_940.Alarm_Type, 'CRISIS'), :);
data_940_WARNING = data_940(ismember(data_940.Alarm_Type, 'WARNING'), :);
data_940_ADVISORY = data_940(ismember(data_940.Alarm_Type, 'ADVISORY'), :);
data_940_SYSTEM = data_940(ismember(data_940.Alarm_Type, 'SYSTEM'), :);

numdata_940_CRISIS = height(data_940_CRISIS);
numdata_940_WARNING = height(data_940_WARNING);
numdata_940_ADVISORY = height(data_940_ADVISORY);
numdata_940_SYSTEM = height(data_940_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_942_CRISIS = data_942(ismember(data_942.Alarm_Type, 'CRISIS'), :);
data_942_WARNING = data_942(ismember(data_942.Alarm_Type, 'WARNING'), :);
data_942_ADVISORY = data_942(ismember(data_942.Alarm_Type, 'ADVISORY'), :);
data_942_SYSTEM = data_942(ismember(data_942.Alarm_Type, 'SYSTEM'), :);

numdata_942_CRISIS = height(data_942_CRISIS);
numdata_942_WARNING = height(data_942_WARNING);
numdata_942_ADVISORY = height(data_942_ADVISORY);
numdata_942_SYSTEM = height(data_942_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_943_CRISIS = data_943(ismember(data_943.Alarm_Type, 'CRISIS'), :);
data_943_WARNING = data_943(ismember(data_943.Alarm_Type, 'WARNING'), :);
data_943_ADVISORY = data_943(ismember(data_943.Alarm_Type, 'ADVISORY'), :);
data_943_SYSTEM = data_943(ismember(data_943.Alarm_Type, 'SYSTEM'), :);

numdata_943_CRISIS = height(data_943_CRISIS);
numdata_943_WARNING = height(data_943_WARNING);
numdata_943_ADVISORY = height(data_943_ADVISORY);
numdata_943_SYSTEM = height(data_943_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_944_CRISIS = data_944(ismember(data_944.Alarm_Type, 'CRISIS'), :);
data_944_WARNING = data_944(ismember(data_944.Alarm_Type, 'WARNING'), :);
data_944_ADVISORY = data_944(ismember(data_944.Alarm_Type, 'ADVISORY'), :);
data_944_SYSTEM = data_944(ismember(data_944.Alarm_Type, 'SYSTEM'), :);

numdata_944_CRISIS = height(data_944_CRISIS);
numdata_944_WARNING = height(data_944_WARNING);
numdata_944_ADVISORY = height(data_944_ADVISORY);
numdata_944_SYSTEM = height(data_944_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_946_CRISIS = data_946(ismember(data_946.Alarm_Type, 'CRISIS'), :);
data_946_WARNING = data_946(ismember(data_946.Alarm_Type, 'WARNING'), :);
data_946_ADVISORY = data_946(ismember(data_946.Alarm_Type, 'ADVISORY'), :);
data_946_SYSTEM = data_946(ismember(data_946.Alarm_Type, 'SYSTEM'), :);

numdata_946_CRISIS = height(data_946_CRISIS);
numdata_946_WARNING = height(data_946_WARNING);
numdata_946_ADVISORY = height(data_946_ADVISORY);
numdata_946_SYSTEM = height(data_946_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_947_CRISIS = data_947(ismember(data_947.Alarm_Type, 'CRISIS'), :);
data_947_WARNING = data_947(ismember(data_947.Alarm_Type, 'WARNING'), :);
data_947_ADVISORY = data_947(ismember(data_947.Alarm_Type, 'ADVISORY'), :);
data_947_SYSTEM = data_947(ismember(data_947.Alarm_Type, 'SYSTEM'), :);

numdata_947_CRISIS = height(data_947_CRISIS);
numdata_947_WARNING = height(data_947_WARNING);
numdata_947_ADVISORY = height(data_947_ADVISORY);
numdata_947_SYSTEM = height(data_947_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_952_CRISIS = data_952(ismember(data_952.Alarm_Type, 'CRISIS'), :);
data_952_WARNING = data_952(ismember(data_952.Alarm_Type, 'WARNING'), :);
data_952_ADVISORY = data_952(ismember(data_952.Alarm_Type, 'ADVISORY'), :);
data_952_SYSTEM = data_952(ismember(data_952.Alarm_Type, 'SYSTEM'), :);

numdata_952_CRISIS = height(data_952_CRISIS);
numdata_952_WARNING = height(data_952_WARNING);
numdata_952_ADVISORY = height(data_952_ADVISORY);
numdata_952_SYSTEM = height(data_952_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_953_CRISIS = data_953(ismember(data_953.Alarm_Type, 'CRISIS'), :);
data_953_WARNING = data_953(ismember(data_953.Alarm_Type, 'WARNING'), :);
data_953_ADVISORY = data_953(ismember(data_953.Alarm_Type, 'ADVISORY'), :);
data_953_SYSTEM = data_953(ismember(data_953.Alarm_Type, 'SYSTEM'), :);

numdata_953_CRISIS = height(data_953_CRISIS);
numdata_953_WARNING = height(data_953_WARNING);
numdata_953_ADVISORY = height(data_953_ADVISORY);
numdata_953_SYSTEM = height(data_953_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_955_CRISIS = data_955(ismember(data_955.Alarm_Type, 'CRISIS'), :);
data_955_WARNING = data_955(ismember(data_955.Alarm_Type, 'WARNING'), :);
data_955_ADVISORY = data_955(ismember(data_955.Alarm_Type, 'ADVISORY'), :);
data_955_SYSTEM = data_955(ismember(data_955.Alarm_Type, 'SYSTEM'), :);

numdata_955_CRISIS = height(data_955_CRISIS);
numdata_955_WARNING = height(data_955_WARNING);
numdata_955_ADVISORY = height(data_955_ADVISORY);
numdata_955_SYSTEM = height(data_955_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_956_CRISIS = data_956(ismember(data_956.Alarm_Type, 'CRISIS'), :);
data_956_WARNING = data_956(ismember(data_956.Alarm_Type, 'WARNING'), :);
data_956_ADVISORY = data_956(ismember(data_956.Alarm_Type, 'ADVISORY'), :);
data_956_SYSTEM = data_956(ismember(data_956.Alarm_Type, 'SYSTEM'), :);

numdata_956_CRISIS = height(data_956_CRISIS);
numdata_956_WARNING = height(data_956_WARNING);
numdata_956_ADVISORY = height(data_956_ADVISORY);
numdata_956_SYSTEM = height(data_956_SYSTEM);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.1
scores.('score_921') = 4*numdata_921_CRISIS + 3*numdata_921_WARNING + 2*numdata_921_ADVISORY + numdata_921_SYSTEM;
scores.('score_923') = 4*numdata_923_CRISIS + 3*numdata_923_WARNING + 2*numdata_923_ADVISORY + numdata_923_SYSTEM;
scores.('score_940') = 4*numdata_940_CRISIS + 3*numdata_940_WARNING + 2*numdata_940_ADVISORY + numdata_940_SYSTEM;
scores.('score_942') = 4*numdata_942_CRISIS + 3*numdata_942_WARNING + 2*numdata_942_ADVISORY + numdata_942_SYSTEM;
scores.('score_943') = 4*numdata_943_CRISIS + 3*numdata_943_WARNING + 2*numdata_943_ADVISORY + numdata_943_SYSTEM;
scores.('score_944') = 4*numdata_944_CRISIS + 3*numdata_944_WARNING + 2*numdata_944_ADVISORY + numdata_944_SYSTEM;
scores.('score_946') = 4*numdata_946_CRISIS + 3*numdata_946_WARNING + 2*numdata_946_ADVISORY + numdata_946_SYSTEM;
scores.('score_947') = 4*numdata_947_CRISIS + 3*numdata_947_WARNING + 2*numdata_947_ADVISORY + numdata_947_SYSTEM;
scores.('score_952') = 4*numdata_952_CRISIS + 3*numdata_952_WARNING + 2*numdata_952_ADVISORY + numdata_952_SYSTEM;
scores.('score_953') = 4*numdata_953_CRISIS + 3*numdata_953_WARNING + 2*numdata_953_ADVISORY + numdata_953_SYSTEM;
scores.('score_955') = 4*numdata_955_CRISIS + 3*numdata_955_WARNING + 2*numdata_955_ADVISORY + numdata_955_SYSTEM;
scores.('score_956') = 4*numdata_956_CRISIS + 3*numdata_956_WARNING + 2*numdata_956_ADVISORY + numdata_956_SYSTEM;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Result of calculation
% scores = 
% 
%     score_921: 90
%     score_923: 1244 -- 2
%     score_940: 4201 -- 1
%     score_942: 319
%     score_943: 524
%     score_944: 466
%     score_946: 157
%     score_947: 706
%     score_952: 355
%     score_953: 738
%     score_955: 21
%     score_956: 234
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3.2
% Analyze 940 and 923
% @TODO

numBeds940 = height(data_940);
numBeds923 = height(data_923);

time_940_Start = [data_940.StartTime(1)];
for i=1:2616,
    time_940_Start = [time_940_Start,data_940.StartTime(i) ];  
end

time_940_End = [data_940.StopTime(1)];
for i=1:2616,
    time_940_End = [time_940_End,data_940.StopTime(i) ];  
end

time_923_Start = [data_923.StartTime(1)];
for i=1:784,
    time_923_Start = [time_923_Start,data_923.StartTime(i) ];  
end

time_923_End = [data_923.StopTime(1)];
for i=1:784,
    time_923_End = [time_923_End,data_923.StopTime(i) ];  
end

%%All values for time are in the lists above. We need to average
% (time_940_End - time_940)/numel(time_940_End)
% (time_923_End - time_923)/numel(time_923_End)
% Need to convert to num from string
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time_940_Start_date = [data_940.StartTime(1)];
for i = 1:numel(time_940_Start),
   x = str2double(datestr(time_940_Start{i}, 'HH'));
   y = str2double(datestr(time_940_Start{i}, 'mm'));
   z = str2double(datestr(time_940_Start{i}, 'ss.FFF'));
   seconds = 3600000*x + 60000*y + 1000*z;
   
   time_940_Start_date = [time_940_Start_date, seconds];
end
time_940_End_date = [data_940.StartTime(1)];
for i = 1:numel(time_940_End),
   x = str2double(datestr(time_940_End{i}, 'HH'));
   y = str2double(datestr(time_940_End{i}, 'mm'));
   z = str2double(datestr(time_940_End{i}, 'ss.FFF'));
  
   seconds = 3600000*x + 60000*y + 1000*z;
   
   time_940_End_date = [time_940_End_date, seconds];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time_923_Start_date = [data_923.StartTime(1)];
for i = 1:numel(time_923_Start),
   x = str2double(datestr(time_923_Start{i}, 'HH'));
   y = str2double(datestr(time_923_Start{i}, 'mm'));
   z = str2double(datestr(time_923_Start{i}, 'ss.FFF'));
   
   seconds = 3600000*x + 60000*y + 1000*z;
   
   time_923_Start_date = [time_923_Start_date, seconds];
end
time_923_End_date = [data_923.StartTime(1)];
for i = 1:numel(time_923_End),
   x = str2double(datestr(time_923_End{i}, 'HH'));
   y = str2double(datestr(time_923_End{i}, 'mm'));
   z = str2double(datestr(time_923_End{i}, 'ss.FFF'));
   
   seconds = 3600000*x + 60000*y + 1000*z;
   
   time_923_End_date = [time_923_End_date, seconds];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Remove 0th index from all created arrays
time_940_Start_date_clean = time_940_Start_date(2:length(time_940_Start_date));
time_940_End_date_clean = time_940_End_date(2:length(time_940_End_date));
time_923_Start_date_clean = time_923_Start_date(2:length(time_923_Start_date));
time_923_End_date_clean = time_923_End_date(2:length(time_923_End_date));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time_940_diff = [data_923.StartTime(1)];
for i=1:numel(time_940_Start_date_clean),
    diff = minus(time_940_Start_date_clean{i},time_940_End_date_clean{i});
    time_940_diff = [time_940_diff, diff];
end
time_940_diff_clean = time_940_diff(2:length(time_940_diff));
%%%%%%
time_923_diff = [data_923.StartTime(1)];
for i=1:numel(time_923_Start_date_clean),
    diff = minus(time_923_Start_date_clean{i},time_923_End_date_clean{i});
    time_923_diff = [time_923_diff, diff];
end
time_923_diff_clean = time_923_diff(2:length(time_923_diff));
%%%%%
avg_940 = sum(cell2mat(time_940_diff_clean))/numel(time_940_diff_clean);
avg_923 = sum(cell2mat(time_923_diff_clean))/numel(time_923_diff_clean);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp(avg_940); %1.6091e+03 ms%%%%
    disp(avg_923); %4.7238e+03 ms%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% fclose(fid);