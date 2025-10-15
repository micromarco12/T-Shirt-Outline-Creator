/*
  # Create prompt library table

  1. New Tables
    - `prompts`
      - `id` (uuid, primary key) - Unique identifier for each prompt
      - `prompt_text` (text) - The actual prompt text
      - `model` (text) - The model this prompt is for (flux-pro or gemini)
      - `is_favorite` (boolean) - Whether this prompt is marked as favorite
      - `created_at` (timestamptz) - When the prompt was created
      - `used_count` (integer) - How many times this prompt has been used

  2. Security
    - Enable RLS on `prompts` table
    - Add policies for public access (no auth required for this tool)
*/

CREATE TABLE IF NOT EXISTS prompts (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  prompt_text text NOT NULL,
  model text DEFAULT 'flux-pro',
  is_favorite boolean DEFAULT false,
  used_count integer DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE prompts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view prompts"
  ON prompts
  FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Anyone can insert prompts"
  ON prompts
  FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Anyone can update prompts"
  ON prompts
  FOR UPDATE
  TO anon
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Anyone can delete prompts"
  ON prompts
  FOR DELETE
  TO anon
  USING (true);