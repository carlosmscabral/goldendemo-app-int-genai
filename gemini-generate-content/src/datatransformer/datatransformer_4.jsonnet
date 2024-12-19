local f = import "functions";

// Reading variables
local project = std.extVar("`CONFIG_vertex-project`");
local region = std.extVar("`CONFIG_vertex-region`");
local gcsURI = std.extVar("gcsURI");
local maxOutputTokens = std.extVar("maxOutputTokens");
local mimeType = std.extVar("mimeType");
local modelName = std.extVar("model-name");
local prompt = std.extVar("prompt");
local temperature = std.extVar("temperature");
// Special use case - we can't have both multimodal and googleSearchGrounding - so
// this code sets googleSearchGrouding to False in case a file is sent, that is
// file has precedence
local googleSearchGrounding = if gcsURI == '' then std.extVar("googleSearchGrounding") else false;


// The next two variables (parts and body) are defined depending on the input for the integration
// For instance, in parts, we only set fileUri if one is given. For body, we set google search grounding accordingly
local parts = if gcsURI != '' then [{"text": prompt}, {"fileData":  {"fileUri": gcsURI,"mimeType": mimeType} } ] 
                            else [{"text": prompt}];

local body = if googleSearchGrounding then {
            "generationConfig" : {
                    "temperature": temperature,
                    "topP": 0.8,
                    "topK": 40.0,
                    "candidateCount": 1.0,
                    "maxOutputTokens": maxOutputTokens,
                    "stopSequences": []
            },
            "contents" : [{
                    "role": "USER",
                    "parts": parts
            }],
            "tools": [{"googleSearchRetrieval" : {}}]
        }
        else {
            "generationConfig" : {
                    "temperature": temperature,
                    "topP": 0.8,
                    "topK": 40.0,
                    "candidateCount": 1.0,
                    "maxOutputTokens": maxOutputTokens,
                    "stopSequences": []
            },
            "contents" : [{
                    "role": "USER",
                    "parts": parts
            }]
        };

// This is where we set the final Payload input towards Vertex/Gemini
{
    "`Task_1_connectorInputPayload`": {
        "Path parameters": {"model": "projects/" + project + "/locations/" + region + "/publishers/google/models/" + modelName },
        "RequestBody": body
    }
}