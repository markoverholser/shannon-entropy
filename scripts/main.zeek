module ShannonEntropy;

export {
  global calculate_shannon_entropy: function(input_string: string): double;
  global calculate_metric_entropy: function(input_string: string): double;
}

function calculate_shannon_entropy(input_string: string): double
{
    input_string = to_lower(input_string);
    local string_length: count = |input_string|;
    #print fmt("String length: %s", string_length);

    local character_map: table[string] of count;

    for (character in input_string)
    {
        if (character in character_map)
        {
            # Seen before, increment counter
            #print fmt("Incrementing counter for character %s", character);
            ++character_map[character];
        }
        else
        {
        	#print fmt("Adding character %s to character_map", character);
            character_map[character] = 1;
        }
    }

    local running_entropy_total: double = 0.0;

    for (item in character_map)
    {
        local probability: double = character_map[item] * 1.0 / string_length;
        #print fmt("p(%s) = %s", item, probability);

        local x: double = probability * ln(probability) / ln(2);
        running_entropy_total += x;
    }

    local entropy: double = -running_entropy_total;
    return entropy;
}

function calculate_metric_entropy(input_string: string): double
{
  if (|input_string| > 0)
  {
    return calculate_shannon_entropy(input_string)/|input_string|;
  }
  else
  {
    return 0;
  }
}
