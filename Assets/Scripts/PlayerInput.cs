using UnityEngine;
[RequireComponent(requiredComponent: typeof(PlayerMovement), requiredComponent2: typeof(PlayerActions))]
public class PlayerInput : MonoBehaviour
{
    private PlayerMovement _movement;
    private PlayerActions _actions;


    private void Awake(){
        _movement = GetComponent<PlayerMovement>();
        _actions = GetComponent<PlayerActions>();
    }

    private void Update(){
        
        _movement.upDownInput = Input.GetAxis(axisName: "Vertical");
        _movement.sidewaysInput = Input.GetAxis(axisName: "Horizontal");

        _movement.boostInput = Input.GetButton("Boost");
        
        _actions.fireInput = Input.GetButtonDown(buttonName: "Fire1");
        _actions.secondFireInput = Input.GetButtonDown(buttonName: "Fire2");
        _actions.shieldInput = Input.GetButtonDown(buttonName: "Shield");
        _actions.weaponCycle = Input.GetButtonDown(buttonName: "Weapon Cycle");
        
    }
}

