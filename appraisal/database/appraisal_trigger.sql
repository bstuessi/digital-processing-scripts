-- Create a function to update files based on directory appraisal changes
CREATE OR REPLACE FUNCTION update_files_appraisal()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE files
  SET appraisal = NEW.appraisal
  WHERE directory_id = NEW.id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger that fires after an update on the directories table
CREATE TRIGGER update_files_appraisal_trigger
AFTER UPDATE ON directories
FOR EACH ROW
WHEN (OLD.appraisal IS DISTINCT FROM NEW.appraisal)
EXECUTE FUNCTION update_files_appraisal();

drop trigger update_files_appraisal_trigger on directories;
