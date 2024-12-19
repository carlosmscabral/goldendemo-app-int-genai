
// Import the additional functions library
local f = import "functions";

local geminiOutput = std.parseJson(std.extVar('`Task_1_connectorOutputPayload`')[0].ResponseBody);

{
 output: geminiOutput.candidates[0].content.parts[0].text,
}