/*
  # Add generated images table

  1. New Tables
    - `generated_images`
      - `id` (uuid, primary key) - Unique identifier for each generated image
      - `original_filename` (text) - Original filename of the uploaded image
      - `prompt_text` (text) - The prompt used to generate the outline
      - `image_data` (text) - Base64 encoded image data of the generated outline
      - `mime_type` (text) - MIME type of the generated image (e.g., image/png)
      - `created_at` (timestamptz) - When the image was generated and saved

  2. Security
    - Enable RLS on `generated_images` table
    - Add policies for public access (no auth required for this tool)
    - Users can view, create, and delete their generated images

  3. Notes
    - Images are stored as base64 data URLs for simplicity
    - No authentication required - anyone can save and manage images
    - Created timestamp allows sorting by newest first
*/

CREATE TABLE IF NOT EXISTS generated_images (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  original_filename text NOT NULL DEFAULT '',
  prompt_text text NOT NULL,
  image_data text NOT NULL,
  mime_type text DEFAULT 'image/png',
  created_at timestamptz DEFAULT now()
);

ALTER TABLE generated_images ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view generated images"
  ON generated_images
  FOR SELECT
  TO anon
  USING (true);

CREATE POLICY "Anyone can insert generated images"
  ON generated_images
  FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Anyone can delete generated images"
  ON generated_images
  FOR DELETE
  TO anon
  USING (true);