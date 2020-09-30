using UnityEngine;

public class UIControlInstructions : MonoBehaviour {
    private void Awake(){
        gameObject.SetActive(true);
    }

    private void OnGUI(){
#if ENABLE_LEGACY_INPUT_MANAGER
        if (UnityEngine.Input.anyKey) gameObject.SetActive(false);
#endif
    }
}