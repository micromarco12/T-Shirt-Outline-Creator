import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  throw new Error('Missing Supabase environment variables');
}

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export interface GeneratedImage {
  id: string;
  original_filename: string;
  prompt_text: string;
  image_data: string;
  mime_type: string;
  created_at: string;
}

export async function saveGeneratedImage(
  originalFilename: string,
  promptText: string,
  imageData: string,
  mimeType: string
): Promise<GeneratedImage | null> {
  const { data, error } = await supabase
    .from('generated_images')
    .insert({
      original_filename: originalFilename,
      prompt_text: promptText,
      image_data: imageData,
      mime_type: mimeType,
    })
    .select()
    .maybeSingle();

  if (error) {
    console.error('Error saving image:', error);
    return null;
  }

  return data;
}

export async function getGeneratedImages(): Promise<GeneratedImage[]> {
  const { data, error } = await supabase
    .from('generated_images')
    .select('*')
    .order('created_at', { ascending: false });

  if (error) {
    console.error('Error fetching images:', error);
    return [];
  }

  return data || [];
}

export async function deleteGeneratedImage(id: string): Promise<boolean> {
  const { error } = await supabase
    .from('generated_images')
    .delete()
    .eq('id', id);

  if (error) {
    console.error('Error deleting image:', error);
    return false;
  }

  return true;
}
