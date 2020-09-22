using System;
using UnityEngine;
using static TagsAsStrings;

public class ShieldControl : MonoBehaviour {
    private const float _shieldDamage = 0.5f;
    private PlayerData _playerData;
    [NonSerialized] public bool shieldInput;

    private void Awake(){
        _playerData = GetComponentInParent<PlayerController>().playerData;
    }

    private void Update(){
        if (shieldInput && _playerData.ShieldIsLoaded)
            gameObject.SetActive(true);
        else if (!_playerData.ShieldIsLoaded) gameObject.SetActive(false);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.CompareTag(enemyTag) || !_playerData.ShieldIsLoaded) return;
        other.gameObject.GetComponent<EnemyController>().TakeDamage(_shieldDamage);
        _playerData.ShieldIsLoaded = false;
    }
}